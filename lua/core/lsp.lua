-- lua/core/lsp.lua (Neovim 0.11+ native LSP config)

-- Disable LSP semantic highlighting (keep Treesitter colors)
local function disable_semantic_tokens(client)
  if client.server_capabilities.semanticTokensProvider then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local format_group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = false })

-- Helper: format-on-save for buffers with an attached formatter
local function enable_format_on_save(bufnr)
  vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_group,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({
        bufnr = bufnr,
        timeout_ms = 2000,
        filter = function(client)
          local ft = vim.bo[bufnr].filetype
          if ft == "c" or ft == "cpp" or ft == "objc" or ft == "objcpp" then
            return client.name == "clangd"
          end
          if ft == "rust" then
            return client.name == "rust_analyzer"
          end
          return false
        end,
      })
    end,
  })
end

-- clangd (C/C++)
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--fallback-style=Chromium", -- Force Chromium style when no .clang-format exists
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  on_attach = function(client, bufnr)
    disable_semantic_tokens(client)
    enable_format_on_save(bufnr)
  end,
})

-- pyright (Python) — requires `pyright-langserver` in PATH
vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
  on_attach = function(client)
    disable_semantic_tokens(client)
  end,
})

-- rust-analyzer (Rust)
vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  on_attach = function(client, bufnr)
    disable_semantic_tokens(client)
    enable_format_on_save(bufnr)
  end,
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      check = { command = "clippy" },
    },
  },
})

-- Enable the servers configured above
vim.lsp.enable({
  "clangd",
  "pyright",
  "rust_analyzer",
})

vim.diagnostic.config({
  virtual_text = false,   -- no inline noise
  signs = true,           -- left gutter
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
  },
})

vim.o.signcolumn = "yes"
vim.diagnostic.enable(true)

-- Show diagnostics in the command line on hover (CursorHold)
local last = ""

local function echo_diag()
  local lnum = vim.fn.line(".") - 1
  local d = vim.diagnostic.get(0, { lnum = lnum })
  if #d == 0 then return end

  table.sort(d, function(a, b)
    return (a.severity or 999) < (b.severity or 999)
  end)

  local msg = (d[1].message or ""):gsub("\n", " ")
  local max = math.max(20, math.min(120, vim.o.columns - 20))
  if #msg > max then msg = msg:sub(1, max - 1) .. "…" end

  local key = lnum .. ":" .. msg
  if key == last then return end
  last = key

  vim.api.nvim_echo({ { msg, "None" } }, false, {})
end

local grp = vim.api.nvim_create_augroup("DiagEcho", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
  group = grp,
  callback = echo_diag,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = grp,
  callback = function()
    vim.defer_fn(echo_diag, 10)
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = grp,  -- reuse your DiagEcho augroup
  callback = function()
    last = ""              -- force re-echo
    vim.defer_fn(echo_diag, 20)
  end,
})

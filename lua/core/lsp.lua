-- lua/core/lsp.lua (Neovim 0.11+ native LSP config)

-- Disable LSP semantic highlighting (keep Treesitter colors)
local function disable_semantic_tokens(client)
  if client.server_capabilities.semanticTokensProvider then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

-- clangd (C/C++)
vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  on_attach = function(client)
    disable_semantic_tokens(client)
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
  on_attach = function(client)
    disable_semantic_tokens(client)
  end,
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = { command = "clippy" },
    },
  },
})

-- Enable the servers configured above
vim.lsp.enable({
  "clangd",
  "pyright",
  "rust_analyzer",
})

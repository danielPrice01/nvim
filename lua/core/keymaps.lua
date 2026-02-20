-- lua/core/keymaps.lua

local map = vim.keymap.set
local opts = { silent = true, noremap = true }

-------------------------------------------------------------------------------
-- Telescope (fuzzy finding)
-------------------------------------------------------------------------------
local function telescope_builtin()
  local ok, builtin = pcall(require, "telescope.builtin")
  if not ok then
    vim.notify("Telescope is not loaded yet", vim.log.levels.WARN)
    return nil
  end
  return builtin
end

vim.keymap.set("n", "<leader>ff", function()
  local b = telescope_builtin()
  if b then b.find_files() end
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>fg", function()
  local b = telescope_builtin()
  if b then b.live_grep() end
end, { desc = "Live grep" })

vim.keymap.set("n", "<leader>fb", function()
  local b = telescope_builtin()
  if b then b.buffers() end
end, { desc = "List buffers" })

vim.keymap.set("n", "<leader>fh", function()
  local b = telescope_builtin()
  if b then b.help_tags() end
end, { desc = "Help tags" })

vim.keymap.set("n", "<leader>fm", function()
  local b = telescope_builtin()
  if b then b.marks() end
end, { desc = "Find marks" })

vim.keymap.set("n", "<leader>fr", function()
  local b = telescope_builtin()
  if b then b.registers() end
end, { desc = "Find registers" })

-------------------------------------------------------------------------------
-- Flash
-------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>s", function()
  require("flash").jump({
    search = {
      mode = "search",
    },
    jump = {
      autojump = false,
    },
  })
end, { desc = "Flash jump" })

------------------------------------------------------------------------------
-- Comment.nvim 
------------------------------------------------------------------------------
map({ "n", "v" }, "gc", "<Plug>(comment_toggle_linewise)", { desc = "Toggle comment" })
map("n", "gcc", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment line" })

-------------------------------------------------------------------------------
-- LSP (builtin) navigation / refactor
-------------------------------------------------------------------------------
map("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
map("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
map("n", "gr", function() vim.lsp.buf.references() end, { desc = "Find references" })
map("n", "gi", function() vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
map("n", "gy", function() vim.lsp.buf.type_definition() end, { desc = "Go to type definition" })
map("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "Rename symbol" })

map("n", "[d", function() vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN }, float = false, }) end,
    { desc = "Go to previous error/warning" })

map("n", "]d", function() vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.WARN }, float = false, }) end,
    { desc = "Go to next error/warning" })

map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code action" })

-------------------------------------------------------------------------------
-- File Explorer
-------------------------------------------------------------------------------
-- Neo-tree (primary sidebar)
map("n", "<leader>e", "<cmd>Neotree toggle left<CR>", { desc = "Toggle Neo-tree" })

-- Oil (filesystem editing buffer)
map("n", "<leader>E", function()
  -- If we're already in an Oil buffer, close it (toggle)
  if vim.bo.filetype == "oil" then
    vim.cmd("bd")
    return
  end

  -- If any Oil window exists, close it (toggle off)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "oil" then
      vim.api.nvim_win_close(win, true)
      return
    end
  end

  -- Open Oil fullscreen in the current window
  vim.cmd("Oil")
end, { desc = "Oil (fullscreen toggle)" })

-- K => man page (always)
vim.keymap.set("n", "K", "<cmd>Man<cr>", { silent = true })

map("n", "<leader>w", "<cmd>w<CR>", { desc = "Write file" })
map("n", "<leader>x", "<cmd>x<CR>", { desc = "Write + quit" })
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })

-------------------------------------------------------------------------------
-- Window Management
-------------------------------------------------------------------------------
map("n", "<leader>wv", "<C-w>v", opts)
map("n", "<leader>ws", "<C-w>s", opts)
map("n", "<leader>wx", "<C-w>c", opts)

-- Open terminal in current window
map("n", "<leader>wt", function()
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, { desc = "Open terminal in current window", silent = true })

-------------------------------------------------------------------------------
-- Buffer Management
-------------------------------------------------------------------------------
map("n", "<leader>bn", ":bnext<CR>",     { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bN", ":enew<CR>",      { desc = "New empty buffer" })
map("n", "<leader>bd", ":bdelete<CR>",   { desc = "Delete buffer" })
map("n", "<leader>bl", ":ls<CR>",        { desc = "List buffers" })

-- Close all buffers except current (no cursor jump)
map("n", "<leader>bc", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end, { desc = "Close all other buffers", silent = true })

-- Delete current buffer and go to previous one
map("n", "<leader>bk", ":bdelete #<CR>", {
  desc = "Delete buffer and go to previous",
  silent = true,
})

map("n", "<leader>bt", function()
  require("plugins.bufterm").goto_term()
end, { desc = "Jump to terminal buffer" })

-------------------------------------------------------------------------------
-- Harpoon (lazy-safe!)
-------------------------------------------------------------------------------
local function with_harpoon(callback)
  return function(...)
    local ok, harpoon = pcall(require, "harpoon")
    if not ok then
      vim.notify("Harpoon is not loaded yet", vim.log.levels.WARN)
      return
    end
    callback(harpoon, ...)
  end
end

map("n", "<leader>a", with_harpoon(function(h)
  h:list():add()
end), { desc = "Harpoon add file" })

map("n", "<leader>h", with_harpoon(function(h)
  h.ui:toggle_quick_menu(h:list())
end), { desc = "Harpoon menu" })

map("n", "<leader>1", with_harpoon(function(h) h:list():select(1) end))
map("n", "<leader>2", with_harpoon(function(h) h:list():select(2) end))
map("n", "<leader>3", with_harpoon(function(h) h:list():select(3) end))
map("n", "<leader>4", with_harpoon(function(h) h:list():select(4) end))
map("n", "<leader>5", with_harpoon(function(h) h:list():select(5) end))

-------------------------------------------------------------------------------
-- FloatingWindow
-------------------------------------------------------------------------------
vim.keymap.set(
  "n",
  "<leader>fl",
  function()
    vim.cmd("FlWin")
  end,
  { desc = "Toggle floating window" }
)

-------------------------------------------------------------------------------
-- Quality of Life
-------------------------------------------------------------------------------
-- :noh
vim.keymap.set("n", "<leader>no", ":noh<CR>", { silent = false })

map("n", "ss", function()
  vim.cmd("normal! s")
end, { desc = "Substitute char" })

-- center screen after half page jumps
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Center screen after jump list navigation
map("n", "<C-o>", "<C-o>zz", opts)
map("n", "<C-i>", "<C-i>zz", opts)

-- Recenter after jumping to a mark
local function jump_to_mark_and_center(cmd)
  return function()
    local mark = vim.fn.getcharstr()          -- read the next key (mark name)
    vim.cmd("normal! " .. cmd .. mark)        -- jump
    vim.cmd("normal! zz")                     -- recenter
  end
end

vim.keymap.set("n", "'", jump_to_mark_and_center("'"), { noremap = true, silent = true })
vim.keymap.set("n", "`", jump_to_mark_and_center("`"), { noremap = true, silent = true })

-- Exit terminal mode quickly
map("t", "<Esc><Esc>", [[<C-\><C-n>]], opts)


-- lua/core/keymaps.lua

local map = vim.keymap.set
local opts = { silent = true, noremap = true }

-------------------------------------------------------------------------------
-- Telescope (fuzzy finding)
-------------------------------------------------------------------------------
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>",  { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",   { desc = "Grep in project" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",     { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",   { desc = "Help" })

-------------------------------------------------------------------------------
-- File Explorer
-------------------------------------------------------------------------------
map("n", "<leader>e", ":NERDTreeToggle<CR>",             { desc = "File explorer" })

-------------------------------------------------------------------------------
-- Window Navigation
-------------------------------------------------------------------------------
map("n", "<leader>wh", "<C-w>h", opts)                    -- move left
map("n", "<leader>wj", "<C-w>j", opts)                    -- move down
map("n", "<leader>wk", "<C-w>k", opts)                    -- move up
map("n", "<leader>wl", "<C-w>l", opts)                    -- move right

-------------------------------------------------------------------------------
-- Window Management
-------------------------------------------------------------------------------
map("n", "<leader>wv", "<C-w>v", opts)                    -- vertical split
map("n", "<leader>ws", "<C-w>s", opts)                    -- horizontal split
map("n", "<leader>wx", "<C-w>c", opts)                    -- close window

-------------------------------------------------------------------------------
-- Buffer Management
-------------------------------------------------------------------------------
map("n", "<leader>bn", ":bnext<CR>",                     { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>",                 { desc = "Previous buffer" })

map("n", "<leader>bN", ":enew<CR>",                      { desc = "New empty buffer" })
map("n", "<leader>bd", ":bdelete<CR>",                   { desc = "Delete buffer" })

map("n", "<leader>bl", ":ls<CR>",                        { desc = "List buffers" })
map("n", "<leader>bc", ":%bd | e# | bd#<CR>",            { desc = "Close all other buffers", silent = true })

-------------------------------------------------------------------------------
-- Harpoon (lazy-safe!) 
-------------------------------------------------------------------------------

-- Wrapper so Harpoon loads only when needed, avoiding startup errors
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

-- Add file to Harpoon
map("n", "<leader>a", with_harpoon(function(h)
  h:list():append()
end), { desc = "Harpoon add file" })

-- Open Harpoon quick menu
map("n", "<leader>h", with_harpoon(function(h)
  h.ui:toggle_quick_menu(h:list())
end), { desc = "Harpoon menu" })

-- Quick jumps
map("n", "<leader>1", with_harpoon(function(h) h:list():select(1) end))
map("n", "<leader>2", with_harpoon(function(h) h:list():select(2) end))
map("n", "<leader>3", with_harpoon(function(h) h:list():select(3) end))
map("n", "<leader>4", with_harpoon(function(h) h:list():select(4) end))
map("n", "<leader>5", with_harpoon(function(h) h:list():select(5) end))

-------------------------------------------------------------------------------
-- Reload Config
-------------------------------------------------------------------------------
map("n", "<leader>r", ":Lazy reload<CR>",                { desc = "Reload config" })

-------------------------------------------------------------------------------
-- Quality of Life
-------------------------------------------------------------------------------
map("n", "<C-d>", "<C-d>zz", opts)                       -- centered scrolling
map("n", "<C-u>", "<C-u>zz", opts)

-- Exit terminal mode
map("t", [[<C-\><C-n>]], "<Esc><Esc>", opts)

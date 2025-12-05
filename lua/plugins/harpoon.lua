-- lua/plugins/harpoon.lua

local harpoon = require("harpoon")

harpoon:setup()

-- Keymaps
local map = vim.keymap.set

-- Add current file to Harpoon list
map("n", "<leader>a", function()
  harpoon:list():append()
end, { desc = "Harpoon add file" })

-- Show Harpoon list
map("n", "<leader>h", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })

-- Jump to files 1–5
map("n", "<leader>1", function() harpoon:list():select(1) end)
map("n", "<leader>2", function() harpoon:list():select(2) end)
map("n", "<leader>3", function() harpoon:list():select(3) end)
map("n", "<leader>4", function() harpoon:list():select(4) end)
map("n", "<leader>5", function() harpoon:list():select(5) end)

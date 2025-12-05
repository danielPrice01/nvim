-- lua/plugins/telescope.lua
local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
})

local builtin = require("telescope.builtin")

-- Keymaps (using <leader>f…)
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "List buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Help tags" })

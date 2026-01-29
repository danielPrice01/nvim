-- lua/plugins/colorscheme.lua
vim.opt.background = "dark"

-- default theme
vim.cmd.colorscheme("kanagawa-wave")

local function set_theme(name)
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify(("Failed to load colorscheme '%s': %s"):format(name, err), vim.log.levels.ERROR)
  end
end

-- Commands
vim.api.nvim_create_user_command("Gruvbox", function()
  set_theme("gruvbox")
end, {})

vim.api.nvim_create_user_command("KanagawaW", function()
  set_theme("kanagawa-wave")
end, {})

vim.api.nvim_create_user_command("KanagawaD", function()
  set_theme("kanagawa-dragon")
end, {})

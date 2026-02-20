-- inia.lua

-- 1. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Core settings
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lsp")

-- 3. Load plugin specs from lua/plugins/init.lua
local plugins = require("plugins")

require("lazy").setup(plugins, {
  change_detection = {
    enabled = false,
    notify = false,
  },
})

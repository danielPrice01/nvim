-- lua/core/autocmds.lua

-- C/C++ specific options
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.cindent = true
  end,
})

-------------------------------------------------------------------------------
-- NERDTree Line Numbers
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nerdtree",
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = false
  end,
})

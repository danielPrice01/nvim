-- lua/core/autocmds.lua

-- C/C++ specific options
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.expandtab = true
    vim.opt_local.cindent = true
  end,
})

-------------------------------------------------------------------------------
-- Oil sidebar settings 
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    -- numbers in the sidebar
    vim.opt_local.number = true
    vim.opt_local.relativenumber = false

    -- keep sidebar a fixed width
    vim.wo.winfixwidth = true
    pcall(vim.api.nvim_win_set_width, 0, 30)

    -- make it visually quieter
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = function()
    if vim.bo.filetype ~= "oil" then return end

    local ok, oil = pcall(require, "oil")
    if not ok then return end

    local dir = oil.get_current_dir()
    if not dir then return end

    -- show relative to cwd (e.g. ./src/foo)
    vim.wo.winbar = "Oil: " .. vim.fn.fnamemodify(dir, ":.")
  end,
})

-------------------------------------------------------------------------------
-- Clipboard: only yanks update system clipboard (+/*). Deletes won't.
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.operator ~= "y" then
      return
    end

    -- Get exactly what was yanked
    local lines = vim.v.event.regcontents or {}
    local text = table.concat(lines, "\n")
    if vim.v.event.regtype == "V" then
      text = text .. "\n"
    end

    -- Copy to system clipboard registers
    vim.fn.setreg("+", text)
    vim.fn.setreg("*", text)
  end,
})

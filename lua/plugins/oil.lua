-- lua/plugins/oil.lua
local ok, oil = pcall(require, "oil")
if not ok then
  return
end

local function oil_dir()
  -- Prefer Oil API
  local dir = oil.get_current_dir()
  if dir and dir ~= "" then
    return vim.fn.fnamemodify(dir, ":p")
  end

  -- Fallback: derive from Oil buffer name (oil:///abs/path/)
  local name = vim.api.nvim_buf_get_name(0)
  local as_path = vim.uri_to_fname(name)
  return vim.fn.fnamemodify(as_path, ":p")
end

local function open_in_main_window(path, oil_win)
  path = vim.fn.fnamemodify(path, ":p")

  -- Find a non-oil window (your "main" window)
  local target_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local b = vim.api.nvim_win_get_buf(win)
    if vim.bo[b].filetype ~= "oil" then
      target_win = win
      break
    end
  end

  -- If only Oil exists, create a right split for the file
  if not target_win then
    vim.cmd("rightbelow vsplit")
    target_win = vim.api.nvim_get_current_win()
  end

  -- Open file in target window (use :edit to avoid “empty buffer” issues)
  vim.api.nvim_set_current_win(target_win)
  vim.cmd("edit " .. vim.fn.fnameescape(path))

  -- Return focus to Oil window (acts like a sidebar)
  if oil_win and vim.api.nvim_win_is_valid(oil_win) then
    vim.api.nvim_set_current_win(oil_win)
  end
end

oil.setup({
  -- keep it minimal if you want
  columns = { "icon" },

  keymaps = {
    ["<CR>"] = function()
      local oil_win = vim.api.nvim_get_current_win()
      local entry = oil.get_cursor_entry()
      if not entry then
        return
      end

      local dir = oil_dir()
      local path = vim.fs.joinpath(dir, entry.name)

      if entry.type == "directory" then
        oil.open(path)
      else
        open_in_main_window(path, oil_win)
      end
    end,
  },
})

-- lua/bufterm.lua
local M = {}

local function is_term_buf(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then return false end
  if not vim.api.nvim_buf_is_loaded(bufnr) then return false end
  return vim.bo[bufnr].buftype == "terminal"
end

local function term_score(bufnr)
  -- Higher is "more recent". Fallback to 0 if not set.
  -- vim.fn.getbufinfo returns lastused timestamps.
  local info = vim.fn.getbufinfo(bufnr)[1]
  return (info and info.lastused) or 0
end

function M.goto_term()
  -- 1) collect terminal buffers
  local term_bufs = {}
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if is_term_buf(b) then
      table.insert(term_bufs, b)
    end
  end

  if #term_bufs == 0 then
    vim.notify("No terminal buffer found", vim.log.levels.INFO)
    return
  end

  -- 2) prefer a terminal that's already visible
  local wins = vim.api.nvim_list_wins()
  for _, w in ipairs(wins) do
    local b = vim.api.nvim_win_get_buf(w)
    if is_term_buf(b) then
      vim.api.nvim_set_current_win(w)
      return
    end
  end

  -- 3) otherwise choose most recently used terminal buffer
  table.sort(term_bufs, function(a, b)
    return term_score(a) > term_score(b)
  end)

  vim.api.nvim_set_current_buf(term_bufs[1])
end

return M


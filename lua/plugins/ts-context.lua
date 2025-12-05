-- lua/plugins/ts-context.lua

local ok, context = pcall(require, "treesitter-context")
if not ok then
  return
end

context.setup({
  enable = true,           -- enable the plugin (can be toggled later)
  max_lines = 5,           -- how many lines of context to show
  min_window_height = 0,   -- show context at any window height
  line_numbers = true,     -- show line numbers for context lines
  multiline_threshold = 20,
  trim_scope = "outer",    -- which scope to keep if too long
  mode = "cursor",         -- or "topline"
  separator = nil,         -- you can set a line like "-" or "─"
})

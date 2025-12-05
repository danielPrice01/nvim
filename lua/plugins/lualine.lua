-- lua/plugins/lualine.lua

local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

lualine.setup({
  options = {
    theme = "gruvbox",
    icons_enabled = true,

    -- Rounded powerline separators
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },

  sections = {
    -- LEFT SIDE
    lualine_a = { "mode" },         -- NORMAL / INSERT / VISUAL
    lualine_b = { "branch" },       -- Git branch
    lualine_c = { "filename" },     -- File name

    -- RIGHT SIDE
    lualine_x = { "filetype" },     -- File extension
    lualine_y = { "progress" },     -- 40% through file
    lualine_z = { "location" },     -- Ln#, Col#
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})

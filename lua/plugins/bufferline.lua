-- lua/plugins/bufferline.lua

local ok, bufferline = pcall(require, "bufferline")
if not ok then
  return
end

bufferline.setup({
  options = {
    -- Show the real buffer ID (matches :ls)
    numbers = function(opts)
      return tostring(opts.id)
    end,

    -- ENABLE ICONS
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,

    -- options are: slant, thin, thick, padded_slant
    separator_style = "thin",

    -- Optional but improves visuals
    diagnostics = false,      -- or "nvim_lsp" if you want LSP symbols
    always_show_bufferline = true,
  },
})

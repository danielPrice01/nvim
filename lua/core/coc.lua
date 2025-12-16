-- lua/core/keymaps.lua

-- Disable automatic popup
vim.g.coc_suggest_auto_trigger = "none"

-- Don't interfere with Vim's completion
vim.g.coc_disable_startup_warning = 1

-- Smaller, cleaner UI
vim.g.coc_global_extensions = {
  "coc-clangd",
  "coc-pyright",
  "coc-json",
  "coc-yaml",
  "coc-snippets",
  "coc-sh",
}

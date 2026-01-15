-- lua/plugins/ale.lua
local g = vim.g

vim.filetype.add({
  extension = {
    cc = "cpp",
  },
})

-------------------------------------------------------------------------------
-- Linters
-------------------------------------------------------------------------------
g.ale_linters = {
  python = { "flake8" },
  c      = { "gcc" },
  cpp    = { "g++" },
}

-------------------------------------------------------------------------------
-- Fixers
-------------------------------------------------------------------------------
g.ale_fixers = {
  python = { "autopep8" },
  c      = { "clang-format" },
  cpp    = { "clang-format" },
}

-- Format on save
g.ale_fix_on_save = 1

-------------------------------------------------------------------------------
-- Compiler options (linting)
-------------------------------------------------------------------------------
g.ale_cpp_gcc_options   = "-std=c++20 -Wall -O2"
g.ale_cpp_clang_options = "-std=c++20 -Wall -O2"

-------------------------------------------------------------------------------
-- clang-format configuration
-------------------------------------------------------------------------------
g.ale_c_clangformat_executable   = "clang-format"
g.ale_cpp_clangformat_executable = "clang-format"

g.ale_c_clangformat_options   = "--style=Chromium --verbose"
g.ale_cpp_clangformat_options = "--style=Chromium --verbose"

-------------------------------------------------------------------------------
-- Diagnostics UI (MINIMAL)
-------------------------------------------------------------------------------

-- Disable underlines / highlights in text
g.ale_set_highlights = 0

-- Disable virtual text completely
g.ale_virtualtext_cursor = 0
g.ale_virtualtext_prefix = ""

-- Keep only gutter signs (subtle)
g.ale_sign_error = "▎"
g.ale_sign_warning = "▎"
g.ale_sign_info = "▎"
g.ale_sign_style_error = "▎"
g.ale_sign_style_warning = "▎"

-- Reduce noise
g.ale_lint_on_text_changed = "never"
g.ale_lint_on_insert_leave = 0

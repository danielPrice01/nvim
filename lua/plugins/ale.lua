-- lua/plugins/ale.lua
local g = vim.g

-- Linters
g.ale_linters = {
  python = { "flake8" },
  c      = { "gcc" },
  cpp    = { "g++" },
}

-- Fixers
g.ale_fixers = {
  python = { "autopep8" },
  c      = { "clang-format" },
  cpp    = { "clang-format" },
}

-- Format on save
g.ale_fix_on_save = 1

-- Compiler options (linting)
g.ale_cpp_gcc_options   = "-std=c++20 -Wall -O2"
g.ale_cpp_clang_options = "-std=c++20 -Wall -O2"

-- clang-format configuration
g.ale_c_clangformat_executable   = "clang-format"
g.ale_cpp_clangformat_executable = "clang-format"

g.ale_c_clangformat_options   = "--style=Chromium --verbose"
g.ale_cpp_clangformat_options = "--style=Chromium --verbose"

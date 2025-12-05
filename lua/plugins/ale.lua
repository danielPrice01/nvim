-- lua/plugins/ale.lua
local g = vim.g

g.ale_linters = {
  python = { "flake8" },
  c      = { "gcc" },
  cpp    = { "g++" },
}

g.ale_fixers = {
  python = { "autopep8" },
  c      = { "clang-format" },
  cpp    = { "clang-format" },
}

g.ale_fix_on_save       = 1
g.ale_cpp_gcc_options   = "-std=c++20 -Wall -O2"
g.ale_cpp_clang_options = "-std=c++20 -Wall -O2"

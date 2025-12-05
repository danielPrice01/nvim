-- lua/core/options.lua
local opt = vim.opt
local g   = vim.g
local fn  = vim.fn

-- Leader keys
g.mapleader = " "
g.maplocalleader = " "

vim.cmd("syntax on")

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.softtabstop = 4
opt.autoindent = true
opt.smartindent = true

-- Search
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true

-- UI
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.splitbelow = true
opt.splitright = true
opt.backspace = { "indent", "eol", "start" }

-- Undo
local undodir = fn.expand("~/.config/nvim/undodir")
if fn.isdirectory(undodir) == 0 then
  fn.mkdir(undodir, "p")
end
opt.undofile = true
opt.undodir = undodir

-- Shell
opt.shell = "/bin/bash"

-- Clipboard (macOS)
opt.clipboard = { "unnamed", "unnamedplus" }
if fn.has("mac") == 1 or fn.has("macunix") == 1 then
  g.clipboard = {
    name = "macOS-clipboard",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
    cache_enabled = 0,
  }
end

-- Disable default matchparen
opt.showmatch = false
g.loaded_matchparen = 1

vim.cmd("filetype plugin indent on")

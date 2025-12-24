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

-- Clipboard (portable default: don't force system clipboard everywhere)
-- If you want system clipboard on all OSes, set: opt.clipboard = "unnamedplus"
opt.clipboard = ""

-- Disable default matchparen
opt.showmatch = false
g.loaded_matchparen = 1

vim.cmd("filetype plugin indent on")

-- Oil: make prompts use command-line instead of popups (minimal UI)
vim.ui.input = function(opts, on_confirm)
  local prompt = (opts and opts.prompt) or ""
  local default = (opts and opts.default) or ""
  local result = vim.fn.input(prompt, default)
  on_confirm(result)
end

vim.ui.select = function(items, opts, on_choice)
  local prompt = ((opts and opts.prompt) or "Select") .. "\n"
  local lines = {}
  for i, item in ipairs(items) do
    local label = item
    if type(item) == "table" and opts and opts.format_item then
      label = opts.format_item(item)
    end
    lines[#lines + 1] = string.format("%d. %s", i, tostring(label))
  end
  local choice = tonumber(vim.fn.input(prompt .. table.concat(lines, "\n") .. "\n> "))
  if choice and items[choice] then
    on_choice(items[choice], choice)
  else
    on_choice(nil, nil)
  end
end

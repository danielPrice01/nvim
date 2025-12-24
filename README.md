# Neovim Configuration (Portable Setup)

This repository contains my **Neovim configuration**, written in Lua and intended to work consistently across macOS, Linux, Docker containers, and Windows (recommended via WSL).

---

## Features Overview

- Plugin manager: lazy.nvim
- Fuzzy finding & grep: telescope.nvim
- Syntax highlighting: nvim-treesitter
- Sticky context header: nvim-treesitter-context
- File tree: neo-tree.nvim
- Filesystem editing buffer: oil.nvim
- Statusline: lualine.nvim
- Buffer tabs: bufferline.nvim
- Quick file navigation: harpoon (v2)
- Linting & formatting: ALE
- Comments: Comment.nvim
- Colorscheme: gruvbox
- LSP support: built-in Neovim LSP + nvim-lspconfig
  - clangd (C / C++)
  - pyright (Python)
  - rust-analyzer (Rust)

---

## Neovim Version Requirement

Neovim ≥ 0.10 (0.11 works)

---

## macOS Setup

brew install neovim git ripgrep fd
brew install llvm
brew install python
pip3 install --user flake8 autopep8
brew install node
npm install -g pyright
brew install rustup
rustup-init -y
~/.cargo/bin/rustup component add rust-analyzer

---

## Linux (Ubuntu / Debian) Setup

sudo apt update
sudo apt install -y neovim git ripgrep fd-find
mkdir -p ~/.local/bin
ln -sf "$(which fdfind)" ~/.local/bin/fd
sudo apt install -y clang clangd clang-format gcc g++
sudo apt install -y make
sudo apt install -y python3 python3-pip
pip3 install --user flake8 autopep8
sudo apt install -y nodejs npm
sudo npm install -g pyright
sudo apt install -y curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
~/.cargo/bin/rustup component add rust-analyzer

---

## Linux (Arch) Setup

sudo pacman -S --needed neovim git ripgrep fd make
sudo pacman -S --needed clang llvm gcc
sudo pacman -S --needed python python-pip
pip install --user flake8 autopep8
sudo pacman -S --needed nodejs npm
sudo npm install -g pyright
sudo pacman -S --needed rustup
rustup default stable
rustup component add rust-analyzer

---

## Windows (WSL) Setup

sudo apt update
sudo apt install -y neovim git ripgrep fd-find
mkdir -p ~/.local/bin
ln -sf "$(which fdfind)" ~/.local/bin/fd
sudo apt install -y clang clangd clang-format gcc g++
sudo apt install -y make
sudo apt install -y python3 python3-pip
pip3 install --user flake8 autopep8
sudo apt install -y nodejs npm
sudo npm install -g pyright
sudo apt install -y curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
~/.cargo/bin/rustup component add rust-analyzer

---

## Docker (Ubuntu/Debian-based)

apt update
apt install -y neovim git ripgrep fd-find make clang clangd clang-format gcc g++ python3 python3-pip nodejs npm curl
mkdir -p /root/.local/bin
ln -sf "$(which fdfind)" /root/.local/bin/fd
pip3 install --user flake8 autopep8
npm install -g pyright
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
/root/.cargo/bin/rustup component add rust-analyzer

---

## After Installation (All Systems)

nvim
:Lazy sync
:TSInstall lua c cpp bash json yaml vim vimdoc python rust
:checkhealth
:LspInfo

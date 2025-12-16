# Neovim Configuration (Portable Setup)

This repository contains my **Neovim configuration**, written in Lua and designed to work consistently across:

- **macOS**
- **Linux**
- **Docker containers**
- **Windows** (recommended via WSL)

The philosophy of this config is:
- Minimal but powerful
- Explicit control over behavior
- No intrusive UI popups
- Portability across machines and environments

---

## Features Overview

- Plugin manager: **lazy.nvim**
- Fuzzy finding & grep: **telescope.nvim**
- Syntax highlighting: **nvim-treesitter**
- Sticky context header: **nvim-treesitter-context**
- File tree: **NERDTree**
- Statusline: **lualine**
- Buffer tabs: **bufferline**
- Quick file navigation: **harpoon (v2)**
- Linting & formatting: **ALE**
- Colorscheme: **gruvbox**
- LSP support (config present)
- Autocomplete: **coc.nvim** (manual trigger only)

---

## Neovim Version Requirement

This config is intended for:

- **Neovim ≥ 0.9**
- Recommended: **Neovim 0.10 / 0.11**

---

## macOS

```sh
# Neovim
brew install neovim

# Core tools
brew install git ripgrep fd

# C / C++ tooling
brew install llvm
brew install clang-format

# Python tooling
brew install python
pip3 install --user flake8 autopep8
```

---
## Linux (Ubuntu/Debian)

```sh
# Neovim
sudo apt update
sudo apt install -y neovim

# Core tools
sudo apt install -y git ripgrep fd-find

# fd binary fix (Ubuntu)
ln -s $(which fdfind) ~/.local/bin/fd

# C / C++ tooling
sudo apt install -y clang clangd clang-format gcc g++

# Build tools (Treesitter)
sudo apt install -y make

# Python tooling
sudo apt install -y python3 python3-pip
pip3 install --user flake8 autopep8
```
---
## Linux (Arch)

```sh
# Neovim
sudo pacman -S neovim

# Core tools
sudo pacman -S git ripgrep fd

# C / C++ tooling
sudo pacman -S clang llvm gcc

# Python tooling
sudo pacman -S python python-pip
pip install --user flake8 autopep8
```
---
## Windows (WSL)

```sh
# Neovim
sudo apt update
sudo apt install -y neovim

# Core tools
sudo apt install -y git ripgrep fd-find

# fd binary fix
ln -s $(which fdfind) ~/.local/bin/fd

# C / C++ tooling
sudo apt install -y clang clangd clang-format gcc g++

# Build tools
sudo apt install -y make

# Python tooling
sudo apt install -y python3 python3-pip
pip3 install --user flake8 autopep8
```

---
## After Installation (All Systems)
```sh
# Open Neovim
nvim

# Install Treesitter parsers
:TSInstall lua c cpp bash json yaml vim vimdoc

# Verify tools
:checkhealth
```

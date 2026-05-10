# Neovim Configuration

Personal Neovim config in Lua. Plugins managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

## Plugins

- telescope.nvim — fuzzy finding & grep
- neo-tree.nvim — file tree
- oil.nvim — filesystem editing buffer
- flash.nvim — quick motion / jump
- harpoon (v2) — quick file navigation
- nvim-treesitter — syntax highlighting
- nvim-treesitter-context — sticky context header
- nvim-lspconfig — LSP support (clangd, pyright, rust-analyzer)
- lualine.nvim — statusline
- bufferline.nvim — buffer tabs
- Comment.nvim — comments
- mini.surround — surround text objects
- nvim-web-devicons — icons
- Colorscheme: Habamax (built into Neovim)

## What you need to install manually

lazy.nvim installs plugins, but the following are not handled automatically:

### System tools

- `neovim` (≥ 0.11), `git`, `ripgrep`, `fd`

### Treesitter parsers

After first launch, run:

```
:TSInstall lua c cpp bash json yaml vim vimdoc python rust
```

### LSP server binaries

`nvim-lspconfig` only configures LSPs — you must install the binaries yourself:

- `clangd` (C/C++)
- `pyright-langserver` — `npm install -g pyright`
- `rust-analyzer` — `rustup component add rust-analyzer`

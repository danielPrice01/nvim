-- lua/plugins/init.lua

return {

  ------------------------------------------------------------------------------
  -- Colorscheme
  ------------------------------------------------------------------------------
  {
    "morhetz/gruvbox",
    priority = 1000,
    config = function()
      require("plugins.colorscheme")
    end,
  },

  ------------------------------------------------------------------------------
  -- File Tree
  ------------------------------------------------------------------------------
  {
    "preservim/nerdtree",
  },

  ------------------------------------------------------------------------------
  -- ALE (Linter / Formatter)
  ------------------------------------------------------------------------------
  {
    "dense-analysis/ale",
    config = function()
      require("plugins.ale")
    end,
  },

  ------------------------------------------------------------------------------
  -- Autocomplete (coc.nvim)
  ------------------------------------------------------------------------------
  {
    "neoclide/coc.nvim",
    branch = "release",
  },

  ------------------------------------------------------------------------------
  -- Which-Key (shows <leader> maps)
  ------------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  ------------------------------------------------------------------------------
  -- Statusline (Lualine)
  ------------------------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.lualine")
    end,
  },

  ------------------------------------------------------------------------------
  -- Bufferline (top buffer tabs)
  ------------------------------------------------------------------------------
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.bufferline")
    end,
  },

  ------------------------------------------------------------------------------
  -- Treesitter (better syntax & highlighting)
  ------------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,   -- <<< IMPORTANT FIX — load Treesitter at startup
    config = function()
      require("plugins.treesitter")
    end,
  },

  ------------------------------------------------------------------------------
  -- Treesitter Context (sticky scope header)
  ------------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("plugins.ts-context")
    end,
  },


  ------------------------------------------------------------------------------
  -- LSP Config (required for clangd, gd, etc.)
  ------------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
  },

  ------------------------------------------------------------------------------
  -- Harpoon 2 (quick-switching files)
  ------------------------------------------------------------------------------
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      require("plugins.harpoon")
    end,
  },

  ------------------------------------------------------------------------------
  -- Devicons (filetype icons)
  ------------------------------------------------------------------------------
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  ------------------------------------------------------------------------------
  -- Telescope (Fuzzy finder)
  ------------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.telescope")
    end,
  },

}

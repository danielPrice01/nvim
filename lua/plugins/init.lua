-- lua/plugins/init.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

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
    event = { "BufReadPost", "BufNewFile" },
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
  -- Harpoon 2 (quick-switching files)
  ------------------------------------------------------------------------------
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },

    -- IMPORTANT: lazy-load Harpoon AFTER startup
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

})

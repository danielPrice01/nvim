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
  -- Neo-tree (Primary File Explorer Sidebar)
  ------------------------------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
  
        close_if_last_window = true,
        popup_border_style = "rounded",
  
        -- 🔴 Disable all git features
        enable_git_status = false,
        enable_diagnostics = false,
  
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
  
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
  
          -- 🔴 Explicitly disable git integration
          git_status = {
            enabled = false,
          },
  
          -- 🔴 Disable diagnostics in filesystem
          diagnostics = {
            enabled = false,
          },
        },
  
        window = {
          position = "left",
          width = 25,
        },
  
        -- 🔴 Remove extra UI clutter
        default_component_configs = {
          git_status = {
            symbols = {}, -- no git symbols at all
          },
  
          diagnostics = {
            symbols = {}, -- no diagnostics symbols
          },
  
          file_size = {
            enabled = false,
          },
  
          type = {
            enabled = false,
          },
  
          last_modified = {
            enabled = false,
          },
  
          created = {
            enabled = false,
          },
        },
      })
    end,
  },

  ------------------------------------------------------------------------------
  -- Oil.nvim (Filesystem-as-buffer editing)
  ------------------------------------------------------------------------------
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    keys = {
      { "<leader>E", "<cmd>Oil<CR>", desc = "Open Oil (edit filesystem)" },
    },
    config = function()
      require("oil").setup({
        default_file_explorer = false, -- Neo-tree handles browsing
        columns = { "icon" },
        view_options = {
          show_hidden = false,
        },
        skip_confirm_for_simple_edits = false,
      })
    end,
  },

  ------------------------------------------------------------------------------
  -- ALE (Linting / Formatting)
  ------------------------------------------------------------------------------
  {
    "dense-analysis/ale",
    config = function()
      require("plugins.ale")
    end,
  },

  ------------------------------------------------------------------------------
  -- Comment.nvim (gc / gcc)
  ------------------------------------------------------------------------------
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Toggle comment" },
      { "gcc", desc = "Toggle comment line" },
    },
    config = function()
      require("Comment").setup()
    end,
  },

  ------------------------------------------------------------------------------
  -- Which-Key
  ------------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  ------------------------------------------------------------------------------
  -- Statusline
  ------------------------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.lualine")
    end,
  },

  ------------------------------------------------------------------------------
  -- Bufferline
  ------------------------------------------------------------------------------
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.bufferline")
    end,
  },

  ------------------------------------------------------------------------------
  -- Treesitter
  ------------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("plugins.treesitter")
    end,
  },

  ------------------------------------------------------------------------------
  -- Treesitter Context
  ------------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("plugins.ts-context")
    end,
  },

  ------------------------------------------------------------------------------
  -- LSP Config (builtin LSP only)
  ------------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require("core.lsp")
    end,
  },

  ------------------------------------------------------------------------------
  -- Harpoon 2
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
  -- Devicons
  ------------------------------------------------------------------------------
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  ------------------------------------------------------------------------------
  -- Telescope
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

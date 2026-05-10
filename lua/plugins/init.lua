-- lua/plugins/init.lua

return {

  ------------------------------------------------------------------------------
  -- Neo-tree
  ------------------------------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- kept for other plugins; disabled visually here
    },
    config = function()
      require("neo-tree").setup({
  
        --------------------------------------------------------------------------
        -- General behavior (NERDTree-like)
        --------------------------------------------------------------------------
        close_if_last_window = true,
        popup_border_style = "rounded",
  
        -- Fully disable git + diagnostics (NERDTree never showed these)
        enable_git_status = false,
        enable_diagnostics = false,
  
        --------------------------------------------------------------------------
        -- Filesystem
        --------------------------------------------------------------------------
        filesystem = {
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
  
          git_status = { enabled = false },
          diagnostics = { enabled = false },
        },
  
        --------------------------------------------------------------------------
        -- Window layout (classic left sidebar)
        --------------------------------------------------------------------------
        window = {
          position = "left",
          width = 25,
          mappings = {
            ["<CR>"] = "open",     -- open file / expand dir
            ["l"]    = "open",
            ["h"]    = "close_node",
          },
        },
  
        --------------------------------------------------------------------------
        -- Visuals: make it feel like NERDTree, but cleaner
        --------------------------------------------------------------------------
        default_component_configs = {
  
          -- 🔴 No icons at all
          icon = {
            folder_closed = "",
            folder_open   = "",
            folder_empty  = "",
            default       = "",
          },
  
          -- 🔴 No git / diagnostics symbols
          git_status  = { symbols = {} },
          diagnostics = { symbols = {} },
  
          -- 🔴 Remove extra metadata columns
          file_size     = { enabled = false },
          type          = { enabled = false },
          last_modified = { enabled = false },
          created       = { enabled = false },
  
          -- 🔴 No modified symbol
          modified = { symbol = "" },
        },
  
        --------------------------------------------------------------------------
        -- Indentation: simple tree, no arrows or clutter
        --------------------------------------------------------------------------
        indent = {
          indent_size = 2,
          padding = 0,
          with_markers = false,
          indent_marker = "",
          last_indent_marker = "",
          expander_collapsed = "",
          expander_expanded = "",
        },
  
        --------------------------------------------------------------------------
        -- Renderers: ONLY names (closest to NERDTree look)
        --------------------------------------------------------------------------
        renderers = {
          directory = {
            { "name" },
          },
          file = {
            { "name" },
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
    cmd = "Oil",
    config = function()
      require("oil").setup({
        default_file_explorer = false, -- Neo-tree is primary
        columns = {},                 -- no icons, minimal look
        view_options = {
          show_hidden = false,
        },
        skip_confirm_for_simple_edits = false,
      })
    end,
  },

  ------------------------------------------------------------------------------
  -- Flash (quicker search)
  ------------------------------------------------------------------------------
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      },
    },
  },

  ------------------------------------------------------------------------------
  -- Comment.nvim (gc / gcc)
  ------------------------------------------------------------------------------
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },


  ------------------------------------------------------------------------------
  -- mini.surround
  ------------------------------------------------------------------------------
  -- Default mappings:
    -- add = 'sa', -- Add surrounding in Normal and Visual modes
    -- delete = 'sd', -- Delete surrounding
    -- find = 'sf', -- Find surrounding (to the right)
    -- find_left = 'sF', -- Find surrounding (to the left)
    -- highlight = 'sh', -- Highlight surrounding
    -- replace = 'sr', -- Replace surrounding
    --
    -- suffix_last = 'l', -- Suffix to search with "prev" method
    -- suffix_next = 'n', -- Suffix to search with "next" method
  {
    "nvim-mini/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
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
      require("harpoon"):setup()
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
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.telescope")
    end,
  },

  ------------------------------------------------------------------------------
  -- FloatingWindow
  ------------------------------------------------------------------------------
  {
    "danielPrice01/FloatingWindow",
    config = function()
      require("floatingwin").setup()
    end,
  },

  ------------------------------------------------------------------------------
  -- Home
  ------------------------------------------------------------------------------
  {
    "danielPrice01/home",
    lazy = false, -- needs to run on startup to register VimEnter autocmd
    priority = 900, -- load early-ish (below colorscheme if you want)
    config = function()
      require("home").setup()
    end,
  },

}

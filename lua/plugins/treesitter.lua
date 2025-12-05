-- lua/plugins/treesitter.lua

local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

configs.setup({
  -- languages you want installed
  ensure_installed = {
    "c", "cpp", "lua", "python", "bash", "json", "yaml", "vim", "vimdoc",
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>v",     -- start selection
      node_incremental = "<leader>n",   -- expand to larger node
      node_decremental = "<leader>p",   -- shrink selection
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})

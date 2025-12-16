-- lua/core/keymaps.lua

local map = vim.keymap.set
local opts = { silent = true, noremap = true }

-------------------------------------------------------------------------------
-- Telescope (fuzzy finding)
-------------------------------------------------------------------------------

-- Live grep from CWD
map("n", "<leader>fg", function()
  local builtin = require("telescope.builtin")
  builtin.live_grep({
    prompt_title = "Live Grep (CWD)",
    cwd = vim.loop.cwd(),
  })
end, { desc = "Live grep (cwd)" })

-- Live grep but ONLY in current directory (no recursion)
map("n", "<leader>fl", function()
  local builtin = require("telescope.builtin")
  builtin.live_grep({
    prompt_title = "Live Grep (This Directory Only)",
    cwd = vim.loop.cwd(),
    additional_args = function()
      return { "--max-depth", "1" }
    end,
  })
end, { desc = "Live grep (local dir only)" })

-- Directory picker → then grep
map("n", "<leader>fD", function()
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  builtin.find_files({
    prompt_title = "Choose Directory",
    cwd = vim.loop.cwd(),
    find_command = { "fd", "-t", "d" },

    attach_mappings = function(prompt_bufnr, map)
      map("i", "<CR>", function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local dir = entry.path or entry.value

        builtin.live_grep({
          prompt_title = ("Live Grep (%s)"):format(dir),
          cwd = dir,
        })
      end)
      return true
    end,
  })
end, { desc = "Live grep (choose directory)" })

-------------------------------------------------------------------------------
-- Go to Definition / References (coc.nvim)
-------------------------------------------------------------------------------

-- Go to definition
map("n", "gd", "<Plug>(coc-definition)", { silent = true })

-- Go to declaration
map("n", "gD", "<Plug>(coc-declaration)", { silent = true })

-- Find references
map("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Go to implementation
map("n", "gi", "<Plug>(coc-implementation)", { silent = true })

-- Go to type definition
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })

-------------------------------------------------------------------------------
-- File Explorer
-------------------------------------------------------------------------------
map("n", "<leader>e", ":NERDTreeToggle<CR>", { desc = "File explorer" })

-------------------------------------------------------------------------------
-- Window Resizing
-------------------------------------------------------------------------------
-- Increase window height
map("n", "<leader>+", function()
  local step = 5 * vim.v.count1
  vim.cmd("resize +" .. step)
end, {
  desc = "Increase window height",
  silent = true,
})

-- Decrease window height
map("n", "<leader>-", function()
  local step = 5 * vim.v.count1
  vim.cmd("resize -" .. step)
end, {
  desc = "Decrease window height",
  silent = true,
})

-- Decrease window width
map("n", "<leader><", function()
  local step = 5 * vim.v.count1
  vim.cmd("vertical resize -" .. step)
end, {
  desc = "Decrease window width",
  silent = true,
})

-- Increase window width
map("n", "<leader>>", function()
  local step = 5 * vim.v.count1
  vim.cmd("vertical resize +" .. step)
end, {
  desc = "Increase window width",
  silent = true,
})
-------------------------------------------------------------------------------
-- Window Management
-------------------------------------------------------------------------------
map("n", "<leader>wv", "<C-w>v", opts)
map("n", "<leader>ws", "<C-w>s", opts)
map("n", "<leader>wx", "<C-w>c", opts)

-------------------------------------------------------------------------------
-- Buffer Management
-------------------------------------------------------------------------------
map("n", "<leader>bn", ":bnext<CR>",     { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bN", ":enew<CR>",      { desc = "New empty buffer" })
map("n", "<leader>bd", ":bdelete<CR>",   { desc = "Delete buffer" })
map("n", "<leader>bl", ":ls<CR>",        { desc = "List buffers" })

-- Close all buffers except current
map("n", "<leader>bc", ":%bd | e# | bd#<CR>", {
  desc = "Close all other buffers",
  silent = true,
})

-- Delete current buffer and go to previous one
map("n", "<leader>bk", ":bdelete #<CR>", {
  desc = "Delete buffer and go to previous",
  silent = true,
})

-------------------------------------------------------------------------------
-- Harpoon (lazy-safe!)
-------------------------------------------------------------------------------

local function with_harpoon(callback)
  return function(...)
    local ok, harpoon = pcall(require, "harpoon")
    if not ok then
      vim.notify("Harpoon is not loaded yet", vim.log.levels.WARN)
      return
    end
    callback(harpoon, ...)
  end
end

map("n", "<leader>a", with_harpoon(function(h)
  h:list():add()
end), { desc = "Harpoon add file" })

map("n", "<leader>h", with_harpoon(function(h)
  h.ui:toggle_quick_menu(h:list())
end), { desc = "Harpoon menu" })

map("n", "<leader>1", with_harpoon(function(h) h:list():select(1) end))
map("n", "<leader>2", with_harpoon(function(h) h:list():select(2) end))
map("n", "<leader>3", with_harpoon(function(h) h:list():select(3) end))
map("n", "<leader>4", with_harpoon(function(h) h:list():select(4) end))
map("n", "<leader>5", with_harpoon(function(h) h:list():select(5) end))

-------------------------------------------------------------------------------
-- Reload Config
-------------------------------------------------------------------------------
map("n", "<leader>r", ":Lazy reload<CR>", { desc = "Reload config" })

-------------------------------------------------------------------------------
-- Quality of Life
-------------------------------------------------------------------------------
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Exit terminal mode quickly
map("t", "<Esc><Esc>", [[<C-\><C-n>]], opts)

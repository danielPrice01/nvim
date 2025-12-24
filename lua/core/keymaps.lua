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
      -- NOTE: this is passed to ripgrep (rg). It requires rg >= 13.
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

    attach_mappings = function(prompt_bufnr, map2)
      map2("i", "<CR>", function()
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
-- LSP (builtin) navigation / refactor
-------------------------------------------------------------------------------
map("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
map("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
map("n", "gr", function() vim.lsp.buf.references() end, { desc = "Find references" })
map("n", "gi", function() vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
map("n", "gy", function() vim.lsp.buf.type_definition() end, { desc = "Go to type definition" })
map("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "Rename symbol" })

-------------------------------------------------------------------------------
-- File Explorer
-------------------------------------------------------------------------------
-- Neo-tree (primary sidebar)
map("n", "<leader>e", "<cmd>Neotree toggle left<CR>", { desc = "Toggle Neo-tree" })

-- Oil (filesystem editing buffer)
-- Oil sidebar (left) that stays open; <CR> opens files on the right
map("n", "<leader>E", function()
  -- If Oil window exists, close it (toggle)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "oil" then
      vim.api.nvim_win_close(win, true)
      return
    end
  end

  -- Open Oil in left split and focus it
  vim.cmd("topleft vsplit")
  vim.cmd("vertical resize 25")
  vim.cmd("Oil")
end, { desc = "Toggle Oil sidebar" })

-- In Oil: <CR> opens files in the RIGHT window (keeps Oil open),
-- directories stay in Oil.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function(ev)
    local oil = require("oil")

    vim.keymap.set("n", "<CR>", function()
      local entry = oil.get_cursor_entry()
      if not entry then return end

      -- If directory: navigate inside Oil
      if entry.type == "directory" then
        oil.select()
        return
      end

      -- Ensure there's a right-side window
      local sidebar_win = vim.api.nvim_get_current_win()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      if #wins == 1 then
        vim.cmd("rightbelow vsplit")
      end

      -- Go to right window and open file there
      vim.cmd("wincmd l")

      local dir = oil.get_current_dir() or ""
      local path = dir .. entry.name
      vim.cmd("edit " .. vim.fn.fnameescape(path))

      -- Return focus to Oil (keeps it acting like a sidebar)
      vim.api.nvim_set_current_win(sidebar_win)
    end, { buffer = ev.buf, silent = true, noremap = true })
  end,
})

-------------------------------------------------------------------------------
-- Window Resizing
-------------------------------------------------------------------------------
-- Increase window height
map("n", "<leader>+", function()
  local step = 5 * vim.v.count1
  vim.cmd("resize +" .. step)
end, { desc = "Increase window height", silent = true })

-- Decrease window height
map("n", "<leader>-", function()
  local step = 5 * vim.v.count1
  vim.cmd("resize -" .. step)
end, { desc = "Decrease window height", silent = true })

-- Decrease window width
map("n", "<leader><", function()
  local step = 5 * vim.v.count1
  vim.cmd("vertical resize -" .. step)
end, { desc = "Decrease window width", silent = true })

-- Increase window width
map("n", "<leader>>", function()
  local step = 5 * vim.v.count1
  vim.cmd("vertical resize +" .. step)
end, { desc = "Increase window width", silent = true })

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

-- Center screen after jump list navigation
map("n", "<C-o>", "<C-o>zz", opts)
map("n", "<C-i>", "<C-i>zz", opts)

-- Exit terminal mode quickly
map("t", "<Esc><Esc>", [[<C-\><C-n>]], opts)

-- lua/core/lsp.lua

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  -- lspconfig not installed yet (Lazy will install it)
  return
end

-- Basic clangd setup for C/C++
lspconfig.clangd.setup({})

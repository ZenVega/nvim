-- mason setup
require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'rust_analyzer', 'clangd', 'eslint' },
})

-- one on_attach for all servers
local on_attach = function(client, bufnr)
  -- ESLint: run fixes on save
  if client.name == "eslint" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end
end

-- lspconfig
local lspconfig = require("lspconfig")

lspconfig.bashls.setup({ on_attach = on_attach })
lspconfig.clangd.setup({ on_attach = on_attach })
lspconfig.lua_ls.setup({ on_attach = on_attach })
lspconfig.rust_analyzer.setup({ on_attach = on_attach })
lspconfig.eslint.setup({ on_attach = on_attach }) -- ✅ actually register ESLint!

-- diagnostics look
vim.diagnostic.config({
  virtual_text = { prefix = "■", spacing = 4 },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

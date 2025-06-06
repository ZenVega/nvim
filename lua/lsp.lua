require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'lua_ls', 'rust_analyzer', 'clangd' },
	require('mason').setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗"
			}
		}
	})
})

local lspconfig = require('lspconfig')

lspconfig.bashls.setup{}
lspconfig.clangd.setup{
	on_attach = on_attach,
}
vim.diagnostic.config({
  virtual_text = {
    prefix = '●', -- could be '●', '■', '▎', etc.
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

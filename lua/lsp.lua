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
    ensure_installed = { 'lua_ls', 'rust_analyzer', 'clangd', 'bash-ls' },
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

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'lua_ls', 'rust_analyzer', 'clangd', 'bash-ls' },
})

local lspconfig = require('lspconfig')

lspconfig.bashls.setup{}
lspconfig.clangd.setup{
	on_attach = on_attach,
}

local lspconfig = require('lspconfig')

lspconfig.bashls.setup{}
lspconfig.clangd.setup{
	on_attach = on_attach,
}

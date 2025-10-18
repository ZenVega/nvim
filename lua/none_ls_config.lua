-- lua/none_ls_config.lua

local null_ls = require("null-ls")

local sources = {
    -- Ruby
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.diagnostics.rubocop,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

null_ls.setup({
    sources = sources,

    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- Only autoformat Ruby files
                    if vim.bo.filetype == "ruby" then
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end
                end,
            })
        end
    end,
})

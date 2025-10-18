-- ~/.config/nvim/lua/eslint.lua
local M = {}

-- Command to launch the ESLint language server
function M.create_cmd()
    return { "vscode-eslint-language-server", "--stdio" }
end

-- Determine the root directory for ESLint LSP
function M.resolve_root_dir(bufnr)
    local util = require("lspconfig.util")
    local file = vim.api.nvim_buf_get_name(bufnr)
    return util.root_pattern(
        "eslint.config.js",
        "eslint.config.ts",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        "package.json",
        ".git"
    )(file) or vim.loop.cwd()
end

-- Client capabilities for LSP
function M.make_client_capabilities()
    return vim.lsp.protocol.make_client_capabilities()
end

-- Node modules path
function M.resolve_node_path()
    return vim.fn.getcwd() .. "/node_modules"
end

-- Setup nvim-eslint
function M.setup()
    require('nvim-eslint').setup({
        debug = false,
        cmd = M.create_cmd(),
        root_dir = function(bufnr)
            return M.resolve_root_dir(bufnr)
        end,
        filetypes = {
            'javascript', 'javascriptreact', 'javascript.jsx',
            'typescript', 'typescriptreact', 'typescript.tsx',
            'vue', 'svelte', 'astro'
        },
        capabilities = M.make_client_capabilities(),
        settings = {
            validate = 'on',
            useESLintClass = true,
            useFlatConfig = true,
            experimental = { useFlatConfig = true },
            codeActionOnSave = { mode = 'never' },  -- show errors, do not auto-fix
            run = 'onType',                        -- diagnostics as you type
            codeAction = {
                disableRuleComment = { enable = true, location = 'separateLine' },
                showDocumentation = { enable = true },
            },
            format = true,
            quiet = false,
            onIgnoredFiles = 'off',
            options = {},
            rulesCustomizations = {},
            problems = { shortenToSingleLine = false },
            nodePath = function()
                return M.resolve_node_path()
            end,
            workingDirectory = { mode = 'location' },
            workspaceFolder = function(bufnr)
                local git_dir = M.resolve_root_dir(bufnr)
                return {
                    uri = vim.uri_from_fname(git_dir),
                    name = vim.fn.fnamemodify(git_dir, ':t'),
                }
            end,
        },
    })
end

return M

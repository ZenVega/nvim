local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Colorscheme
    "rebelot/kanagawa.nvim",
    {
        'akinsho/bufferline.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },
    -- Navigation
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        "windwp/nvim-ts-autotag",
        ft = { "html", "javascript", "javascriptreact", "typescriptreact", "vue", "svelte", "xml" },
        config = function()
            require("autotag_config")
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "phaazon/hop.nvim",
        lazy = true,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },
    "nvim-tree/nvim-tree.lua",
    {
        "nvim-tree/nvim-web-devicons",
        opts = {}
    },
    -- LSP manager
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
        'esmuellert/nvim-eslint',
        ft = { "javascript", "typescript", "vue", "svelte", "astro" },
        config = function()
            local eslint = require('eslint_config')
            eslint.setup()
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
        config = function()
            require("lsp")
        end,
    },
    -- CPP + Web Formatter
    {
        "nvimdev/guard.nvim",
        dependencies = {
            "nvimdev/guard-collection",
        },
        ft = { "cpp", "hpp", "json", "js", "html", "css" },
        config = function()
            local ft = require("guard.filetype")

            -- C/C++ and JSON using clang-format
            ft("cpp"):fmt("clang-format")
            ft("hpp"):fmt("clang-format")
            ft("json"):fmt("clang-format")

            -- Web: JavaScript, HTML, CSS using prettier
            ft("js"):fmt("prettier")
            ft("html"):fmt("prettier")
            ft("css"):fmt("prettier")
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("none_ls_config")
        end,
    },
    {
        "Shopify/ruby-lsp",
        ft = { "ruby" },
        config = function()
            require("lspconfig").ruby_lsp.setup({})
        end,
    },
    -- 42 Header
    {
        "Diogo-ss/42-header.nvim",
        cmd = { "Stdheader" },
        keys = { "<F1>" },
        opts = {
            default_map = true,                    -- Default mapping <F1> in normal mode.
            auto_update = true,                    -- Update header when saving.
            user = "uschmidt",                     -- Your user.
            mail = "uschmidt@student.42berlin.de", -- Your mail.
        },
        config = function(_, opts)
            require("42header").setup(opts)
        end,
    },
    -- Norminette
    {
        "hardyrafael17/norminette42.nvim",
        config = function()
            local norminette = require("norminette")
            norminette.setup({
                runOnSave = true,
                maxErrorsToShow = 5,
                active = false,
            })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show()
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
       },
    }
})

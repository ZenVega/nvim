---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      -- Automatically ensure these Mason packages are installed
      ensure_installed = {
        -- LSP servers
        "lua-language-server",
        "clangd",
        "solargraph",
        "ruby-lsp",
        "typescript-language-server",
        "tailwindcss-language-server",
        "json-lsp",
        "marksman",
        "vue-language-server", -- Volar for Vue 3 (NOT vetur-vls!)
        -- Tools / formatters / linters
        "stylua",
        "eslint_d",
        "prettier",
        "rubocop",
        "debugpy",
        "tree-sitter-cli",
        "prettier",
        "eslint_d",
        "stylua",
      },
      -- Explicitly ignore/remove vetur-vls (old Vue 2 server)
      auto_install = false,
      automatic_installation = true, -- install missing packages automatically
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "stylua",
        "eslint-lsp",
        -- add more arguments for adding more null-ls sources
      },
    },
  },
}

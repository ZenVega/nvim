---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "lua", "javascript", "typescript", "vue", "ruby", "python", "graphql" },
    highlight = { enable = true },
    indent = { enable = true },
    playground = { enable = true },
  },
}

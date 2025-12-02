---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")

    -- Define sources
    local sources = {
      -- Prettier with explicit filetypes
      null_ls.builtins.formatting.prettier.with({
        filetypes = {
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "astro",
        },
      }),
      -- Add Stylua if you use Lua
      null_ls.builtins.formatting.stylua,
    }

    -- Setup null-ls
    null_ls.setup({
      sources = sources,
      debug = true,
    })
  end,
}

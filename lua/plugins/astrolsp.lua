---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    -- LSP features
    features = {
      codelens = true,
      inlay_hints = true,
      semantic_tokens = false,
    },
    -- Formatting
    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = { "vue", "typescript", "javascript", "css", "scss", "html", "c", "h", "cpp", "hpp", "tpp" },
      },
      disabled = {},
      timeout_ms = 1000,
    },
    -- LSP servers
    servers = {
      "lua_ls",
      "clangd",
      "ruby_lsp",
      "jsonls",
      "vimls",
      "tailwindcss",
      "marksman",
      "eslint",
      "ts_ls",
      "volar", -- Add Volar explicitly
    },
    -- LSP config overrides
    config = (function()
      local mason_path = vim.fn.stdpath "data" .. "/mason/packages"
      local vue_language_server_path = mason_path .. "/vue-language-server/node_modules/@vue/language-server"
      local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
      
      -- Vue TS plugin
      local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
        configNamespace = "typescript",
      }
      
      -- TypeScript LSP
      local ts_ls_config = {
        init_options = {
          plugins = { vue_plugin },
        },
        filetypes = tsserver_filetypes,
        settings = {
          typescript = {
            tsserver = { useSyntaxServer = false },
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      }
      
      -- Vue LSP (Volar) - properly configured
      local volar_config = {
        init_options = {
          vue = {
            hybridMode = false, -- Let Volar handle everything for .vue files
          },
          typescript = {
            tsdk = mason_path .. "/typescript-language-server/node_modules/typescript/lib"
          }
        },
        filetypes = { "vue" },
      }
      
      -- Tailwind CSS (standard config file detection)
      local tailwind_config = {
        filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
        root_dir = function(fname)
          local util = require("lspconfig.util")
          -- Look for tailwind.config.js in app/frontend
          return util.root_pattern(
            "tailwind.config.js",
            "tailwind.config.ts",
            "package.json"
          )(fname)
            or util.find_git_ancestor(fname)
        end,
      }
      
      -- DISABLE vuels (old Vue 2 server)
      local vuels_config = {
        autostart = false, -- This prevents vuels from starting
      }
      
      return {
        ts_ls = ts_ls_config,
        volar = volar_config,
        --tailwindcss = tailwind_config,
        --vuels = vuels_config, -- Explicitly disable
      }
    end)(),
    -- Handlers
    handlers = {},
    -- Auto commands
    autocmds = {},
    -- Mappings
    mappings = {},
    -- Custom on_attach
    on_attach = function(client, bufnr)
      -- Auto-fix ESLint on save
      if client.name == "eslint" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end
    end,
  },
}

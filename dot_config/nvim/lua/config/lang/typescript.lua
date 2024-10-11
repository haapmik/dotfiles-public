local default_inlayhints = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = false,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

---@type CustomLangConfig
return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  rootMarkers = {
    ".git",
    "node_modules",
  },
  treesitter = {
    "javascript",
    "typescript",
  },
  formatting = {
    formatters = {
      "prettier",
    },
    excluded_paths = {
      "/node_modules/",
    },
  },
  linting = {
    linters = {
      "eslint",
      "biomejs",
    },
    excluded_paths = {
      "/node_modules/",
    },
  },
  lspconfig = {
    servers = {
      vtsls = {
        enabled = false,
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      },
      ts_ls = {
        enabled = true,
        typescript = {
          inlayHints = default_inlayhints,
        },
        javascript = {
          inlayHints = default_inlayhints,
        },
      },
      biome = {
        enabled = true,
      },
    },
  },
}

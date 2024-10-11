---@type CustomLangConfig
return {
  filetypes = { "cs" },
  treesitter = {
    "c_sharp",
  },
  formatting = {
    formatters = {
      "csharpier",
    },
  },
  lspconfig = {
    servers = {
      omnisharp = {
        enabled = true,
        settings = {
          RoslynExtensionsOptions = {
            InlayHintsOptions = {
              EnableForParameters = true,
              ForLiteralParameters = true,
              ForIndexerParameters = true,
              ForObjectCreationParameters = true,
              ForOtherParameters = true,
              SuppressForParametersThatDifferOnlyBySuffix = false,
              SuppressForParametersThatMatchMethodIntent = false,
              SuppressForParametersThatMatchArgumentName = false,
              EnableForTypes = true,
              ForImplicitVariableTypes = true,
              ForLambdaParameterTypes = true,
              ForImplicitObjectCreatio = true,
            },
          },
        },
      },
    },
  },
}

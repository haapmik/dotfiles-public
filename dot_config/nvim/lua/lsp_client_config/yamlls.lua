local yaml_companion = require("yaml-companion").setup({
  builtin_matchers = {
    kubernetes = { enabled = false },
  },
  lspconfig = {
    filetypes = { "yaml", "yml" },
  },
})

return yaml_companion

local util = require("lspconfig.util")

return {
  cmd = { "helm_ls", "serve" },
  filetypes = { "helm" },
  root_dir = function(fname)
    return util.root_pattern("Chart.yaml")(fname)
  end,
  settings = {
    ["helm-ls"] = {
      yamlls = {
        enabled = false,
      },
    },
  },
}

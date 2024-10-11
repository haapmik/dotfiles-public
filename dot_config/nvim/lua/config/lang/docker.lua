---@type CustomLangConfig
return {
  filetypes = {
    "dockerfile",
  },
  treesitter = {
    "dockerfile",
  },
  lspconfig = {
    servers = {
      dockerls = { enabled = true },
      docker_compose_language_server = { enabled = true },
    }
  }
}

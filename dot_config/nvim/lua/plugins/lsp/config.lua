local M = {}

M.servers = {} ---@type table<string, lspconfig.Config>

---Sets a list of configured LSP servers.
---
---Will read LSP definitions from `config.lang.<language>`.
---@param common_servers? table<string, lspconfig.Config>
function M.set_servers(common_servers)
  -- Load language specific LSP server configuration
  local languages = require("config.lang")

  M.servers = common_servers or {}

  -- Include all language specific LSP configurations
  for _, language in ipairs(languages) do
    if language.lspconfig ~= nil or language.lspconfig.servers ~= nil then
      for server, server_opts in pairs(language.lspconfig.servers) do
        M.servers[server] = vim.tbl_deep_extend("force", M.servers[server] or {}, server_opts)
      end
    end
  end
end

M.capabilities = {} ---@type lsp.ClientCapabilities

---Sets global definitions related to LSP client capabilities
---@param capabilities? lsp.ClientCapabilities
function M.set_global_capabilities(capabilities)
  local has_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")

  M.capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp_lsp and cmp_lsp.default_capabilities() or {},
    capabilities
  )
end

M.on_attach = function(client, bufnr)
  local has_inlay_hints, inlay_hints = pcall(require, "inlay-hints")
  if has_inlay_hints then
    inlay_hints.on_attach(client, bufnr)
  end
end

---Configures LSP server by name.
---@param name string
---@return nil
function M.setup_server(name)
  local opts = M.servers[name]

  -- Skip if the server is not enabled or defined
  if type(opts) ~= "table" or opts.enabled == false then
    return
  end

  -- Set capabilities for the server
  opts.capabilities = vim.tbl_deep_extend("keep", opts.capabilities or {}, M.capabilities)

  -- Set on_attach for the server
  opts.on_attach = M.on_attach

  -- Utilize server handler if available
  local has_handler, handler = pcall(require, "plugins.lsp.handlers." .. name)
  if has_handler and handler(name, opts) then
    return
  end

  require("lspconfig")[name].setup(opts)
end

---Configures `mason-lspconfig` plugin if it's installed.
---@return nil
function M.configure_mason()
  ---@type MasonLspconfigSettings
  local opts = {
    ensure_installed = {},
    handlers = { M.setup_server },
  }

  local has_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")

  -- Skip if mason-lspconfig has not been installed
  if not has_mason_lsp then
    return
  end

  -- Get a list of Mason LSP packages
  local mason_lsp_packages = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

  -- Require that all the supported LSP servers are installed
  for server, server_opts in pairs(M.servers) do
    if server_opts.enabled ~= false and vim.tbl_contains(mason_lsp_packages, server) then
      table.insert(opts.ensure_installed, server)
    end
  end

  mason_lsp.setup(opts)
end

---Configures all LSP servers with default lspconfig.
---
---Will skip LSP servers that can installed via `mason-lspconfig` plugin,
---if the plugin has been installed.
---@return nil
function M.configure_servers()
  local has_mason_lsp, _ = pcall(require, "mason-lspconfig")

  -- Get a list of Mason LSP packages if available
  local mason_lsp_packages = {}
  if has_mason_lsp then
    mason_lsp_packages = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  end

  -- Configure LSP servers via lspconfig
  for server, server_opts in pairs(M.servers) do
    if server_opts.enabled ~= false then
      if not vim.tbl_contains(mason_lsp_packages, server) then
        M.setup_server(server)
      end
    end
  end
end

return M

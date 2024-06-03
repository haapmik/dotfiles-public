local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "folke/neodev.nvim",
    "williamboman/mason-lspconfig.nvim",
    "creativenull/efmls-configs-nvim",
    "b0o/SchemaStore.nvim",
    "lvimuser/lsp-inlayhints.nvim",
    "lukas-reineke/lsp-format.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
  },
}

local function create_client_capabilities()
  -- Include default client capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Add cmp-nvim capabilities for code completion
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  -- Add nvim-ufo capabilities
  capabilities.textDocument = capabilities.textDocument or {}
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

local function get_lsp_client_configs(lsp_client)
  local opts = {}

  -- Prepare autoformatter
  local lsp_format = require("lsp-format")
  local lsp_format_config = {}
  local completions = vim.fn.getcompletion("", "filetype")
  if completions ~= nil then
    for _, v in pairs(completions) do
      lsp_format_config[v] = { sync = true } -- Asynchronous causes problems with multiple buffers
    end
  end
  lsp_format.setup(lsp_format_config)

  opts.capabilities = create_client_capabilities()
  opts.on_attach = function(client, bufnr)
    lsp_format.on_attach(client, bufnr)

    if client.supports_method("textDocument/inlayHint") then
      require("lsp-inlayhints").on_attach(client, bufnr)
    end
  end

  -- LSP client specific configuration
  local client_config_status, client_config = pcall(require, "lsp_client_config." .. lsp_client)
  if client_config_status then
    for key, value in pairs(client_config) do
      opts[key] = value
    end
  end

  return opts
end

function M.config()
  -- IMPORTANT: this should be the first line!
  require("neodev").setup({
    library = {
      plugins = { "neotest" },
      types = true,
    },
  })

  require("sonarlint").setup({
    server = {
      cmd = {
        "sonarlint-language-server",
        -- Ensure that sonarlint-language-server uses stdio channel
        "-stdio",
        "-analyzers",
        -- paths to the analyzers you need, using those for python and java in this example
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonargo.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonariac.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarlintomnisharp.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarphp.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonartext.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarxml.jar"),
      },
    },
    filetypes = {
      -- Tested and working
      "python",
      "cpp",
      "java",
      "javascript",
      "typescript",
      "html",
      "php",
      "python",
      "xml",
      "yaml",
      "css",
      "kubernetes",
      "terraform",
    },
  })

  local lspconfig = require("lspconfig")
  local lsp_client_list = require("mason-lspconfig").get_installed_servers()
  for _, lsp_client in pairs(lsp_client_list) do
    local opts = get_lsp_client_configs(lsp_client)
    lspconfig[lsp_client].setup(opts)
  end
end

return M

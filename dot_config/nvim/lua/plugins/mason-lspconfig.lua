local M = {
  "williamboman/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
}

function M.config()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "ansiblels",
      "bashls",
      "clangd",
      "cssls",
      "docker_compose_language_service",
      "dockerls",
      "efm",
      "html",
      "intelephense",
      "jsonls",
      "marksman",
      "prismals",
      "pyright",
      "rust_analyzer",
      "sqlls",
      "tailwindcss",
      "taplo",
      "tsserver",
      "vimls",
      "yamlls",
    },
    -- Automatically install servers that were configured via lspconfig
    automatic_installation = true,
  })
end

return M

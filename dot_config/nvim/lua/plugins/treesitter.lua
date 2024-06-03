local M = {
  -- Tree-sitter general parser for syntax tree generation.
  -- Provides better syntax highlighting
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mfussenegger/nvim-jdtls",
  },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "php",
      "python",
      "typescript",
      "vim",
      "vimdoc",
    },
    auto_install = true,
    incremental_selection = {
      enable = true,
    },
    highlight = {
      enable = true,
    },
    indent = {
      -- this is an experimental feature
      enable = true,
    },
  })
end

return M

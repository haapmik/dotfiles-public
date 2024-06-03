return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "gitignore",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "php",
        "prisma",
        "python",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = true,
      incremental_selection = {
        enable = true,
        keymaps = {
          scope_incremental = false,
          node_incremental = "<space>",
          node_decremental = "<bs>",
        },
      },
      highlight = {
        enable = true,
      },
      indent = {
        -- this is an experimental feature
        enable = true,
      },
    })
  end,
}

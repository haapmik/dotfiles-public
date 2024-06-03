local M = {
  "williamboman/mason.nvim",
  lazy = false,
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
}

return M

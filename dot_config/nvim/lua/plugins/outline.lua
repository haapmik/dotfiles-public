local M = {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  opts = {
    symbol_folding = {
      autofold_depth = 1,
      auto_unfold = {
        hovered = true,
        only = 2,
      },
    },
    outline_items = {
      show_symbol_details = false,
    },
  },
}

return M

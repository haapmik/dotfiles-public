local M = {
  "lvimuser/lsp-inlayhints.nvim",
  event = { "LspAttach" },
  opts = {
    inlay_hints = {
      only_current_line = false, -- Avoid code pollution with inlay hints
    },
  },
}

return M

local M = {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
}

function M.config()
  require("symbols-outline").setup({
    position = "right",
    relative_width = false,
    width = 25, -- relative_width in px
    auto_close = true,
    wrap = true,
  })
end

return M

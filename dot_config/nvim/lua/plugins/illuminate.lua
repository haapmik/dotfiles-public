local M = {
  "RRethy/vim-illuminate",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  require("illuminate").configure({
    providers = {
      "lsp",
      "treesitter",
    },
    under_cursor = false, -- disable illumination under cursor
  })

  -- All references with no type/definition information
  vim.api.nvim_set_hl(0, "IlluminatedWordText", { standout = true })

  -- Original definition of the variable
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { standout = true })

  -- All references to the definition
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { standout = true })
end

return M

local M = {
  "lewis6991/hover.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  require("hover").setup({
    init = function()
      -- Include providers that you want to use
      require("hover.providers.lsp")
      --require("hover.providers.gh")
      --require("hover.providers.gh_user")
      require("hover.providers.jira")
      require("hover.providers.man")
      require("hover.providers.dictionary")
    end,
  })
end

return M

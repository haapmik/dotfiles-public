return {
  {
    "lewis6991/hover.nvim",
    event = "VeryLazy",
    keys = {
      {
        "K",
        function()
          require("hover").hover()
        end,
        desc = "Hover",
      },
      {
        "KK",
        function()
          require("hover").hover_select()
        end,
        desc = "Hover (select)",
      },
      {
        "<C-p>",
        function()
          require("hover").hover_switch("previous")
        end,
        desc = "Hover (previous source)",
      },
      {
        "<C-n>",
        function()
          require("hover").hover_switch("next")
        end,
        desc = "Hover (next source)",
      },
    },
    opts = {
      init = function()
        require("hover.providers.lsp")
        require("hover.providers.diagnostic")
        require("hover.providers.jira")
      end,
      preview_opts = {
        border = "single",
      },
      preview_window = false,
      title = true,
    },
  },
}

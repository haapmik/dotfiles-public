local M = {
  "norcalli/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  setup = function()
    require("colorizer").setup({
      "*", -- Highlight all files, but customize some others
    }, {
      mode = "background",
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      names = false, -- "Name" codes like Blue
    })
  end,
}

return M

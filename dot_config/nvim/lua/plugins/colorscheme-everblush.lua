local everblush = {
  "Everblush/nvim",
  name = "everblush",
  lazy = false, -- make sure to load colorscheme during startup
  priority = 1000,
  config = function()
    require("everblush").setup()
  end,
}

return everblush

local solarized_osaka = {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("solarized-osaka").setup({
      transparent = true,
      terminal_colors = true,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "Outline", "Trouble" },
      dim_inactive = true,
    })
  end,
}

return solarized_osaka

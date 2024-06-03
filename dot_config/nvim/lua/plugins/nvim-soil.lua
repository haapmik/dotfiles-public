local M = {
  "javiorfo/nvim-soil",
  lazy = true,
  ft = "plantuml",
  config = function()
    -- If you want to change default configurations
    require("soil").setup({
      -- If you want to use Plant UML jar version instead of the install version
      --puml_jar = ".local/share/plantuml/plantuml-1.2023.13.jar",

      -- If you want to customize the image showed when running this plugin
      image = {
        darkmode = false, -- Enable or disable darkmode
        format = "png", -- Choose between png or svg

        -- This is a default implementation of using xsiv to open the resultant image
        -- Edit the string to use your preferred app to open the image
        -- Some examples:
        -- return "feh " .. img
        -- return "xdg-open " .. img
        execute_to_open = function(img)
          return "sxiv -b " .. img
        end,
      },
    })
  end,
}

return {}

local M = {
  "javiorfo/nvim-soil",
  lazy = true,
  ft = "plantuml",
  config = function()
    require("soil").setup({
      -- If you want to use Plant UML jar version instead of the install version
      puml_jar = "$HOME/.local/share/plantuml/plantuml-1.2023.13.jar",
      image = {
        darkmode = false, -- Enable or disable darkmode
        format = "svg", -- Choose between png or svg
        -- This is a default implementation of using xsiv to open the resultant image
        -- Edit the string to use your preferred app to open the image
        -- Some examples:
        -- return "feh " .. img
        -- return "xdg-open " .. img
        -- return "eog " .. img
        execute_to_open = function(img)
          return "eog " .. img .. " &"
        end,
      },
    })

    local autocmd = vim.api.nvim_create_autocmd
    local augroup = vim.api.nvim_create_augroup
    autocmd({ "BufWritePost" }, {
      desc = "Reload PlantUML image",
      group = augroup("open_image", { clear = true }),
      callback = function(opts)
        if vim.bo[opts.buf].filetype == "plantuml" then
          vim.cmd("Soil")
        end
      end,
    })
  end,
}

return M

local M = {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}

function M.config()
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      style_preset = bufferline.style_preset.no_italic,
      themable = true,
      separator_style = "slope",
      indicator = {
        style = "underline",
      },
      hover = {
        enabled = true,
        delay = 0,
        reveal = { "close" },
      },
      modified_icon = "m",
      show_buffer_icons = false,
      left_mouse_command = "buffer %d",
      middle_mouse_command = "bdelete! %d",
      right_mouse_command = nil,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = ""

        if level:match("error") then
          icon = "E"
        elseif level:match("warn") then
          icon = "W"
        end

        if icon ~= "" then
          return icon .. "!"
        end
        return ""
      end,
      groups = {
        options = {
          toggle_hidden_on_enter = true,
        },
        items = {
          {
            name = "Tests",         -- Mandatory
            priority = 2,           -- Relation to other groups
            matcher = function(buf) -- Mandatory
              return buf.path:match(".spec.")
            end,
          },
          -- Leftover buffers
          bufferline.groups.builtin.ungrouped,
        },
      },
    },
  })
end

return {}

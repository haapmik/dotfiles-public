return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "AndreM222/copilot-lualine",
      dependencies = {
        "zbirenbaum/copilot.lua",
      },
    },
  },
  opts = {
    extensions = {
      "trouble",
      "symbols-outline",
      "lazy",
    },
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff" },
      lualine_c = {
        {
          "filename",
          file_status = true,
          newfile_status = true,
          path = 4,
          symbols = {
            unnamed = "[no name]",
            newfile = "[new]",
            readonly = "[!]",
          },
          separator = { right = "" },
        },
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          separator = { right = "" },
        },
        {
          "copilot",
          show_colors = true,
          show_loading = true,
          separator = { right = "" },
        },
        {
          "filetype",
          icon_only = false,
          separator = { right = "" },
        },
        {
          "encoding",
          separator = { right = "" },
        },
        {
          "fileformat",
        },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#ff9e64" },
        },
      },
      lualine_y = {},
      lualine_z = {
        {
          "progress",
          padding = { left = 1, right = 1 },
          separator = { left = "" },
        },
        {
          "location",
          separator = { left = "" },
          padding = { left = 0 },
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          file_status = true,
          newfile_status = true,
          path = 3,
          shorting_target = 80,
          symbols = {
            unnamed = "[no name]",
            newfile = "[new]",
            readonly = "[!]",
          },
          separator = { right = "" },
        },
      },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  },
}

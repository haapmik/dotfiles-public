local M = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = false,
    },
    panel = {
      enabled = false,
      auto_refresh = true,
      layout = {
        position = "bottom", -- bottom | top | left | right
        ratio = 0.4,
      },
    },
    filetypes = {
      markdown = true,
      gitcommit = true,
      yaml = true,
    },
  },
}

return M

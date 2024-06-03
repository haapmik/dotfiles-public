local M = {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      completion = {
        enable = true,
        callSnippet = "Both",
      },
      diagnostics = {
        enable = true,
      },
      hint = {
        enable = true,
      },
      workspace = {
        checkThirdParty = false, -- disable those stupid 'luv' prompts
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

return M

local M = {}

M.settings = {
	Lua = {
		completion = { enable = true },
		diagnostics = { enable = true },
		hint = {
			enable = true,
			setType = false,
			paramName = "All",
			paramType = true,
		},
		telemetry = { enable = false },
	},
}

return M

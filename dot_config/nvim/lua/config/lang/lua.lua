---@type CustomLangConfig
return {
	filetypes = { "lua" },
	treesitter = {
		"lua",
		"luadoc",
		"luap",
	},
	formatting = {
		formatters = {
			"stylua",
		},
		install_with_mason = {
			"stylua",
		},
	},
	linting = {
		linters = {
			"selene",
		},
		install_with_mason = {
			"selene",
		},
	},
	lspconfig = {
		servers = {
			lua_ls = {
				enabled = true,
				Lua = {
					codeLens = { enable = true },
					completion = { enable = true },
					diagnostics = { enable = true },
					format = { enable = true },
					hint = {
						enable = true,
						setType = false,
						paramType = true,
						paramName = "All",
						arrayIndex = "Disabled",
					},
					telemetry = { enable = false },
					workspace = { checkThirdParty = true },
				},
			},
		},
	},
}

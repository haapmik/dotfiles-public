---@type CustomLangConfig
return {
	filetypes = {
		"dockerfile",
	},
	treesitter = {
		"dockerfile",
	},
	linting = {
		linters = {
			"trivy",
		},
		install_with_mason = {
			"trivy",
		},
	},
	lspconfig = {
		servers = {
			dockerls = { enabled = true },
		},
	},
}

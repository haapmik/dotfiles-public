---@type CustomLangConfig
return {
	filetypes = {
		"yaml",
	},
	treesitter = {
		"yaml",
	},
	formatting = {
		formatters = {
			"yamlfmt",
		},
		install_with_mason = {
			"yamlfmt",
		},
	},
	lspconfig = {
		servers = {
			yamlls = {
				enabled = true,
			},
		},
	},
}

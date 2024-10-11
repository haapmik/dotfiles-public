---@type CustomLangConfig
return {
	filetypes = {
		"sh",
	},
	treesitter = {
		"bash",
	},
	formatting = {
		formatters = {
			"shellharden",
		},
		install_with_mason = {
			"shellharden",
		},
		format_on_save = false,
	},
	linting = {
		linters = {
			"shellcheck",
		},
		install_with_mason = {
			"shellcheck",
		},
	},
	lspconfig = {
		servers = {
			bashls = { enabled = true },
		},
	},
}

---@type CustomLangConfig
return {
	filetypes = { "python" },
	treesitter = {
    "python",
    "ninja",
    "rst",
	},
	formatting = {
		formatters = {
			"ruff",
			"black",
		},
	},
  linting = {
    linters = {
      "ruff",
    },
  },
	lspconfig = {
		servers = {
			pylsp = {
				enabled = true,
			},
			ruff = {
				enabled = true,
			},
		},
	},
}

---@type CustomLangConfig
return {
	filetypes = { "css", "html", "php" },
	treesitter = {
    "html",
	},
	formatting = { },
  linting = { },
	lspconfig = {
		servers = {
			cssls = {
				enabled = true,
			},
		},
	},
}

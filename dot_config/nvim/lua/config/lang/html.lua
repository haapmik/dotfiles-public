---@type CustomLangConfig
return {
	filetypes = { "html", "php" },
	treesitter = {
    "html",
    "css",
	},
	formatting = { },
  linting = { },
	lspconfig = {
		servers = {
			html = {
				enabled = true,
			},
		},
	},
}

---@type CustomLangConfig
return {
	filetypes = { "php" },
	treesitter = {
    "php",
    "html",
    "css",
	},
	formatting = {
		formatters = {
			"php_cs_fixer",
		},
    excluded_paths = {
      "/vendor/",
    },
	},
  linting = {
    linters = {
      "psalm",
      "php",
    },
    excluded_paths = {
      "/vendor/",
    },
  },
	lspconfig = {
		servers = {
			phpactor = {
				enabled = true,
			},
		},
	},
}

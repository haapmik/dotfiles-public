---@type CustomLangConfig
return {
	filetypes = { "rust" },
	treesitter = {
		"rust",
		"ron", -- Rust Object Notation
	},
	formatting = {
		formatters = {}, -- rust-analyzer provides formatting
	},
	linting = {
		linters = {}, -- rust-analyzer provides linting
    install_with_mason = {
      "bacon", -- used to provide automation like watch jobs
    }
	},
	lspconfig = {
		servers = {
			rust_analyzer = {
				enabled = true,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						check = {
							command = "clippy", -- use `clippy` instead of default `check`
						},
						checkOnSave = true,
						procMacro = {
							enable = true,
						},
					},
				},
			},
		},
	},
}

vim.filetype.add({
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
	},
})

---@type CustomLangConfig
return {
	filetypes = {
		"yaml.docker-compose",
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
			docker_compose_language_service = { enabled = true },
		},
	},
}

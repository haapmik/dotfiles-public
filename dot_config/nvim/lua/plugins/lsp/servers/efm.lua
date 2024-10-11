local function get_php_configs()
	local phpcs = require("efmls-configs.linters.phpcs")
	phpcs.requireMarker = true

	local psalm = require("efmls-configs.linters.psalm")
	psalm.requireMarker = true

	return {
		phpcs,
		psalm,
	}
end

local function get_javascript_configs()
	local biome_lint = require("efmls-configs.formatters.biome")
	biome_lint.args = "lint --write --stdin-file-path '${INPUT}'"
	biome_lint.requireMarker = true

	return {
		biome_lint,
	}
end

return {
	command = "efm-langserver",
	args = { "-q" },
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
	filetypes = {
		"php",
		"typescript",
		"javascript",
	},
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			php = get_php_configs(),
			typescript = get_javascript_configs(),
			javascript = get_javascript_configs(),
		},
	},
}

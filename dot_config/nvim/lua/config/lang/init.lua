---@class LspconfigOpts
---@field servers? table<string, lspconfig.Config>

---@class ToolingOpts
---@field global_install boolean

---This utilizes `conform.nvim` plugin to provide formatting support.
---@class FormattingOpts
---@field formatters? string[]
---@field install_with_mason? string[] Installed globally with Mason
---@field format_on_save? boolean
---@field excluded_paths? string[]

---This utilizes `nvim-lint` plugin to provide linting support.
---@class LintingOpts
---@field linters? string[]
---@field install_with_mason? string[] Installed globally with Mason
---@field excluded_paths? string[]
---@field excluded_filetypes? string[]

---@class CustomLangConfig
---@field filetypes string[] List of filetypes affected by the definitions.
---@field rootMarkers? string[] List of known root directory markers.
---@field treesitter? string[] List of language support to be installed.
---@field formatting? FormattingOpts Formatting related configuration.
---@field linting? LintingOpts Linting related configuration.
---@field lspconfig? LspconfigOpts LSP related configuration.

---@type CustomLangConfig[]
return {
	require("config.lang.bash"),
	require("config.lang.cs"),
	require("config.lang.css"),
	require("config.lang.docker-compose"),
	require("config.lang.dockerfile"),
	require("config.lang.helm"),
	require("config.lang.html"),
	require("config.lang.lua"),
	require("config.lang.php"),
	require("config.lang.python"),
	require("config.lang.rust"),
	require("config.lang.typescript"),
	require("config.lang.yaml"),
}

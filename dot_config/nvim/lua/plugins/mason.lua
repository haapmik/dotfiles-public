return {
	"williamboman/mason.nvim",
	version = "*",
	cmd = "Mason",
	build = ":MasonUpdate", -- Updates registry contents
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
}

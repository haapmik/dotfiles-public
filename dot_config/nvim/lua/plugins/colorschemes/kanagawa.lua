return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	build = ":KanagawaCompile",
	init = function()
		vim.cmd.colorscheme("kanagawa")
	end,
	---@type KanagawaConfig
	opts = {
		compile = true,
		undercurl = true,
		dimInactive = true,
		terminalColors = false,
		transparent = false,
		theme = "wave", -- default when "background" not set
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		background = {
			-- available options: "wave", "lotus", "dragon"
			dark = "wave",
			light = "lotus",
		},
	},
	overrides = function(colors)
		local theme = colors.theme
		return {
			-- Transparent floating windows
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },

			-- Save an hlgroup with dark background and dimmed foreground
			-- so that you can use it where your still want darker windows.
			-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

			-- Popular plugins that open floats will link to NormalFloat by default;
			-- set their background accordingly if you wish to keep them dark and borderless
			LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
			MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
		}
	end,
}

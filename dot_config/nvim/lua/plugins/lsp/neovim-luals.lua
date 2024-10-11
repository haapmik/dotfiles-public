return {
	{
		-- This is deprecated in favour of `lazydev.nvim`, but is
		-- available here to provide compatibility for nvim <= 0.10.0
		"folke/neodev.nvim",
		version = "*",
		enabled = vim.fn.has("nvim-0.10.0") == 0 and vim.fn.has("nvim-0.7.0") == 1,
		opts = {},
	},
	{
		"folke/lazydev.nvim",
		version = "*",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
		dependencies = {
			"Bilal2453/luvit-meta",
		},
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Optional `vim.uv` typings
		"Bilal2453/luvit-meta",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
}

return {
	"folke/which-key.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		spec = {
			{
				mode = { "n", "v" },
				{ "<leader>c", group = "Code" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>f", group = "File" },
				{ "<leader>s", group = "Search" },
				{ "<leader>n", group = "Notes" },
			},
		},
	},
}

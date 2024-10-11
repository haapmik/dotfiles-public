return {
	{
		"folke/todo-comments.nvim",
		version = "*",
		enabled = vim.fn.has("nvim-0.8.0") == 1,
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			signs = false,
		},
		keys = {
			{ "<leader>nt", "<cmd>TodoTelescope<cr>", desc = "Todo" },
		},
	},
	{
		"folke/ts-comments.nvim",
		version = "*",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
		event = "VeryLazy",
		opts = {},
	},
}

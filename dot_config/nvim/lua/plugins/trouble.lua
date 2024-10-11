return {
	{
		"folke/trouble.nvim",
		version = "*",
		enabled = vim.fn.has("nvim-0.9.2"),
		cmd = { "Trouble" },
		keys = {
			{ "<leader>ct", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics [Trouble]" },
			{ "<leader>cT", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics [Trouble]" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols [Trouble]" },
			{ "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP reference/definitions/... [Trouble]" },
			{ "<leader>cq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List [Trouble]" },
		},
		opts = {
			auto_preview = true,
			auto_open = true,
			auto_close = true,
		},
	},
}

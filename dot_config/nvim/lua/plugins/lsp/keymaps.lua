return {
	{
		"neovim/nvim-lspconfig",
		optional = true,
		keys = {
			{
				"<leader>cä",
				function()
					vim.diagnostic.jump({ count = -1 })
				end,
				desc = "Diagnostics - previous",
			},
			{
				"<leader>cö",
				function()
					vim.diagnostic.jump({ count = 1 })
				end,
				desc = "Diagnostics - next",
			},
			{
				"<leader>ca",
				function()
					vim.lsp.buf.code_action()
				end,
				desc = "Code action",
			},
			{
				"<leader>cf",
				function()
					vim.lsp.buf.format()
				end,
				desc = "Code format [LSP]",
			},
			{
				"<leader>cr",
				function()
					vim.lsp.buf.rename()
				end,
				desc = "Rename definition",
			},
			{
				"<leader>cK",
				function()
					vim.lsp.buf.hover()
				end,
				desc = "Hover information",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		optional = true,
		keys = {
			{
				"<leader>gd",
				function()
					require("telescope.builtin").lsp_definitions({ reuse_win = true })
				end,
				desc = "Goto Definition",
			},
			{
				"<leader>gi",
				function()
					require("telescope.builtin").lsp_implementations({ reuse_win = true })
				end,
				desc = "Goto Implementation",
			},
			{
				"<leader>gD",
				function()
					require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
				end,
				desc = "Goto Type Definition",
			},
			{ "<leader>cd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Diagnostics" },
			{ "<leader>cD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
		},
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				desc = "Code format [Conform]",
			},
		},
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		optional = true,
		keys = {
			{
				"<leader>ci",
				function()
					require("lsp-inlayhints").toggle()
				end,
				desc = "Toggle inlay hints",
			},
		},
	},
}

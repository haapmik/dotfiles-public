return {
	{
		"ThePrimeagen/refactoring.nvim",
		cmd = { "Refactor" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			show_success_message = true,
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
}

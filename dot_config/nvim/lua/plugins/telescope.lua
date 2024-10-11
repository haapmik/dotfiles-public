return {
	{
		"nvim-telescope/telescope.nvim",
		-- We need to load this extension to replace UI elements with Telescope
		event = "VeryLazy",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				enabled = vim.fn.executable("make") == 1 or vim.fn.executable("cmake"),
				build = vim.fn.executable("make") == 1 and "make"
					or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		keys = {
			{ "<leader>T", "<cmd>Telescope<cr>", desc = "Telescope" },
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Grep files",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find buffer",
			},
			{ "<leader>fl", "<cmd>Telescope file_browser<cr>", desc = "File list" },
		},
		config = function()
			local telescope = require("telescope")
			local default_theme = "ivy"
			telescope.setup({
				defaults = {
					theme = default_theme,
					--borderchars = { " " }, -- Enable borderless mode
				},
				pickers = {
					find_files = { theme = default_theme },
					live_grep = { theme = default_theme },
					buffers = { theme = default_theme },
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
						respect_gitignore = false,
					},
					file_browser = {
						theme = default_theme,
						--borderchars = { " " }, -- Enable borderless mode
						hijack_netrw = true,
						grouped = true,
						hidden = true,
						respect_gitignore = false,
					},
					["ui-select"] = {
						require("telescope.themes").get_ivy(),
					},
				},
			})
			telescope.load_extension("file_browser")
			telescope.load_extension("ui-select")
			telescope.load_extension("fzf")
		end,
	},
}

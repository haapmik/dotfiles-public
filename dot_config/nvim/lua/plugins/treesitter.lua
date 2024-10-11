return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- 2024-07-16: Latest release v0.9.2 from 2024-01-29 doesn't work
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			auto_install = true,
			sync_install = false,
			ensure_installed = {
				-- Required to run without errors
				"c",
				"lua",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = { enable = true },
		},
		config = function(_, opts)
			-- Insert filetypes from language configurations
			local langs = require("config.lang")
			for _, lang in ipairs(langs) do
				if lang.treesitter ~= nil then
					for _, filetype in ipairs(lang.treesitter) do
						if not vim.tbl_contains(opts.ensure_installed, filetype) then
							table.insert(opts.ensure_installed, filetype)
						end
					end
				end
			end

			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		version = false, -- Only one release available for nvim v0.7.x compatibility support
		event = { "VeryLazy" },
		enabled = vim.fn.has("nvim-0.9.0") == 1,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			mode = "cursor",
			max_lines = 3,
		},
	},
}

return {
	{
		"zbirenbaum/copilot-cmp",
		event = { "InsertEnter", "LspAttach" },
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("copilot_cmp").setup()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"zbirenbaum/copilot-cmp",
		},
		opts = function(_, opts)
			-- Update sources
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "copilot",
				group_index = 2,
			})

			-- Update sorting rules
			local current_sorting = opts.sorting or {}
			local current_comparators = current_sorting.comparators or {}
			opts.sorting = vim.tbl_deep_extend("force", opts.sorting or {}, {
				comparators = {
					require("copilot_cmp.comparators").prioritize,
					unpack(current_comparators),
				},
			})
		end,
	},
}

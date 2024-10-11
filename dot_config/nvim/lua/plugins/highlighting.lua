local DEFAULT_EVENT = { "BufReadPost", "BufNewFile", "BufWritePre" }

return {
	{
		"norcalli/nvim-colorizer.lua",
		event = DEFAULT_EVENT,
		config = function()
			require("colorizer").setup({
				"*", -- Highlight all files, but customize some others
			}, {
				mode = "background",
				RGB = false, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				names = false, -- "Name" codes like "Azure"
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = DEFAULT_EVENT,
		opts = {
			min_count_to_highlight = 2,
		},
		config = function(_, opts)
			require("illuminate").configure(opts)

			-- All references with no type/definition information
			vim.api.nvim_set_hl(0, "IlluminatedWordText", { standout = true })

			-- Original definition of the variable
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { standout = true })

			-- All references to the definition
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", { standout = true })
		end,
	},
}

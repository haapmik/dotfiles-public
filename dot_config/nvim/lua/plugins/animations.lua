return {
	{
		"anuvyklack/windows.nvim",
		event = "VeryLazy",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			-- Recommended settings
			vim.o.winwidth = 10
			vim.o.winminwidth = 5
			vim.o.equalalways = false

			require("windows").setup({
				ignore = {
					buftype = { "quickfix", "nofile" },
					filetype = { "Trouble", "Outline" },
				},
				autowidth = {
					enable = true,
					winwidth = 0.65,
				},
				animation = {
					enable = true,
					duration = 50,
					fps = 60,
					easing = function(r) -- https://easings.net/#easeOutExpo
						if r == 1 then
							return 1
						else
							return 1 - math.pow(2, -10 * r)
						end
					end,
				},
			})
		end,
	},
}

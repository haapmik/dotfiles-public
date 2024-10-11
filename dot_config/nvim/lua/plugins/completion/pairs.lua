return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
		},
		config = function(_, opts)
			local autopairs = require("nvim-autopairs")
			autopairs.setup(opts)

			local has_cmp, cmp = pcall(require, "cmp")
			if has_cmp then
				local autopairs_cmp = require("nvim-autopairs.completion.cmp")
				cmp.event:on("confirm_done", autopairs_cmp.on_confirm_done())
			end
		end,
	},
}

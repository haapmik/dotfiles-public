return {
	{
		-- This is deprecated in favor of the buildin 0.10.0 snippet support
		-- and `garymjr/nvim-snippets`
		"saadparwaiz1/cmp_luasnip",
		enabled = vim.fn.has("nvim-0.10.0") == 0 and vim.fn.has("nvim-0.7.0") == 1,
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function(_, opts)
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
	},
	{
		"garymjr/nvim-snippets",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
		version = false, -- Really old version
		opts = {
			friendly_snippets = true,
		},
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"saadparwaiz1/cmp_luasnip",
				enabled = vim.fn.has("nvim-0.10.0") == 0 and vim.fn.has("nvim-0.7.0") == 1,
			},
			{
				"garymjr/nvim-snippets",
				enabled = vim.fn.has("nvim-0.10.0") == 1,
			},
		},
		opts = function(_, opts)
			local has_luasnip, luasnip = pcall(require, "luasnip")
			if has_luasnip then
				opts.snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				}
				table.insert(opts.sources, {
					name = "luasnip",
					group_index = 1,
				})
			end

			local has_snippets, snippets = pcall(require, "nvim-snippets")
			if has_snippets then
				opts.snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					end,
				}
				table.insert(opts.sources, {
					name = "snippets",
					group_index = 1,
				})
			end
		end,
	},
}

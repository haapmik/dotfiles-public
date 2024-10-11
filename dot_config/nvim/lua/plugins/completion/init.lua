--local has_words_before = function()
--  if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
--    return false
--  end
--  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
--end

return {
	{
		"hrsh7th/nvim-cmp",
		version = false, -- Really old version
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"zbirenbaum/copilot-cmp",
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			local cmp = require("cmp")
			local cmp_borders = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

			cmp.setup({
				experimental = {
					ghost_text = false,
				},
				formatting = lsp_zero.cmp_format({ details = true }),
				window = {
					completion = {
						border = cmp_borders,
						winhighlight = "Normal:Normal,FloatBorder:None,CursorLine:Visual,Search:None",
					},
					documentation = {
						border = cmp_borders,
						winhighlight = "Normal:Normal,FloatBorder:None,CursorLine:Visual,Search:None",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible_docs() then
							return cmp.scroll_docs(-4)
						end
						fallback()
					end),
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible_docs() then
							return cmp.scroll_docs(4)
						end
						fallback()
					end),
					["<CR>"] = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Insert,
					}),
					["<Tab>"] = cmp.mapping.confirm({
						select = false,
						behavior = cmp.ConfirmBehavior.Replace,
					}),
				}),
				sorting = {
					priority_weight = 2,
					comparators = {
						-- Best matches should always be on top
						cmp.config.compare.exact,

						-- Include Copilot matches as second best
						require("copilot_cmp.comparators").prioritize,

						-- Below is the default comparitor list and order for nvim-cmp
						cmp.config.compare.offset,
						-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				sources = cmp.config.sources({
					{ name = "lazydev" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_document_symbol" },
					{ name = "copilot" },
				}, {
					{ name = "path" },
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = { "InsertEnter", "LspAttach" },
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("copilot_cmp").setup({
				event = { "InsertEnter", "LspAttach" },
				fix_pairs = true,
			})
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	require("plugins.completion.snippets"),
	require("plugins.completion.pairs"),
}

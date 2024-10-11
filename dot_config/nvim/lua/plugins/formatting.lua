return {
	{
		"stevearc/conform.nvim",
		version = "*",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
		lazy = true,
		cmd = { "ConformInfo" },
		init = function()
			-- Use conform with formatexpr
			vim.o.formatexpr = "v.lua.require'conform'.formatexpr()"
		end,
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				desc = "Code format [Conform]",
			},
		},
		---@type conform.setupOpts
		opts = {
			log_level = vim.log.levels.INFO,
			format_on_save = {},
			autoformat_opts = {
				excluded_filetypes = {},
				excluded_paths = {},
			},
			default_format_opts = {
				lsp_format = "fallback",
				stop_after_first = true,
				timeout_ms = 500,
			},
		},
		---@param opts conform.setupOpts|{autoformat_opts:{excluded_filetypes:string[],excluded_paths:string[]}}
		config = function(_, opts)
			local lang = require("utils.lang")

			-- Install configured Mason formatters for each language
			local mason_formatter_list = lang.get_configured_mason_formatters()
			for _, mason_formatter in ipairs(mason_formatter_list) do
				lang.install_with_mason(mason_formatter)
			end

			-- Configure formatters by filetype for each language
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			for filetype, filetype_opts in pairs(lang.get_formatters_by_ft()) do
				if not vim.tbl_contains(vim.tbl_keys(opts.formatters_by_ft), filetype) then
					opts.formatters_by_ft[filetype] = filetype_opts
				else
					vim.tbl_deep_extend("error", opts.formatters_by_ft, { [filetype] = filetype_opts })
				end
			end

			-- Configure autoformat opts
			local lang_autoformat_opts = lang.get_autoformat_opts()
			opts.autoformat_opts = {
				excluded_filetypes = vim.tbl_extend(
					"force",
					{},
					opts.autoformat_opts.excluded_filetypes,
					lang_autoformat_opts.excluded_filetypes
				),
				excluded_paths = vim.tbl_extend(
					"force",
					{},
					opts.autoformat_opts.excluded_paths,
					lang_autoformat_opts.excluded_paths
				),
			}

			-- Configure format on save
			opts.format_on_save = function(bufnr)
				local conform_log = require("conform.log")

				-- Prevent if filetype has been excluded
				local buffer_ft = vim.bo[bufnr].filetype
				if vim.tbl_contains(opts.autoformat_opts.excluded_filetypes, buffer_ft) then
					conform_log.info("Skipping format on save for filetype %s", buffer_ft)
					return
				end

				-- Prevent if file is located in excluded filepath
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				for _, filepath in ipairs(opts.autoformat_opts.excluded_paths) do
					if bufname:match(filepath) then
						conform_log.info("Skipping format on save for filepath match filter %s", filepath)
						return
					end
				end

				return {}
			end

			require("conform").setup(opts)
		end,
	},
}

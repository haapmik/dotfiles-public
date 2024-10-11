return {
	{
		"mfussenegger/nvim-lint",
		enabled = vim.fn.has("nvim-0.7.0") == 1,
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			events = { "BufEnter", "BufReadPost", "BufWritePost", "InsertLeave" },
			linters_by_ft = {},
		},
		config = function(_, opts)
			local lint = require("lint")
			local lang = require("utils.lang")

			-- Include custom linter definitions
			lint.linters.biomejs = require("plugins.linting.linters.biomejs_github")
			lint.linters.trivy_helm = require("plugins.linting.linters.trivy_helm")

			-- Install configured Mason formatters for each language
			local mason_linter_list = lang.get_configured_mason_linters()
			for _, mason_linter in ipairs(mason_linter_list) do
				lang.install_with_mason(mason_linter)
			end

			-- Configure linters by filetype for each language
			opts.linters_by_ft = opts.linters_by_ft or {} ---@type table<string, string[]>
			for filetype, filetype_opts in pairs(lang.get_linters_by_ft()) do
				if not vim.tbl_contains(vim.tbl_keys(opts.linters_by_ft), filetype) then
					opts.linters_by_ft[filetype] = filetype_opts
				else
					vim.tbl_deep_extend("error", opts.linters_by_ft, { [filetype] = filetype_opts })
				end
			end

			lint.linters_by_ft = opts.linters_by_ft

			vim.api.nvim_create_autocmd(opts.events, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = function(event)
					local bufnr = event.buf ---@type integer
					local filetype = vim.bo[bufnr].filetype

					if filetype == nil then
						return
					end

					-- Get a list of linters assigned for the current filetype
					local linter_names = lint._resolve_linter_by_ft(filetype)

					-- Skip if no linters defined for the current buffer
					if #linter_names == 0 then
						return
					end

					-- Fix linter executable paths
					local fs = require("utils.fs")
					for _, linter_name in ipairs(linter_names) do
						local linter_opts = lint.linters[linter_name]

						if linter_opts ~= nil then
							local linter_cmd = linter_opts.cmd

							-- Some linter definitions has defined the `cmd` value
							-- as a function even though this is against the type definitions.
							if type(linter_cmd) ~= "string" then
								linter_cmd = linter_opts.cmd()
							end

							-- Check if linter executable is available,
							-- otherwise try to find it.
							if vim.fn.executable(linter_cmd) == 0 then
								lint.linters[linter_name].cmd = fs.get_executable(linter_cmd)
							end
						end
					end

					-- Provide cwd via LSP
					local get_lsp_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
					local lsp_client = get_lsp_clients({ bufnr = bufnr })[1] or {}

					-- Run linting
					lint.try_lint(nil, { ignore_errors = true, cwd = lsp_client.root_dir })
				end,
			})
		end,
	},
}

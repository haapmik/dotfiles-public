return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
	},
	{
		"neovim/nvim-lspconfig",
		version = "*",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			"VonHeikemen/lsp-zero.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				-- Replaces `neodev`
				"folke/lazydev.nvim",
				enabled = vim.fn.has("nvim-0.10.0") == 1,
				dependencies = {
					"Bilal2453/luvit-meta",
				},
			},
			{
				-- Deprecated in-favor of `lazydev`
				"folke/neodev.nvim",
				enabled = vim.fn.has("nvim-0.10.0") == 0 and vim.fn.has("nvim-0.7.0") == 1,
			},
			{
				"MysticalDevil/inlay-hints.nvim",
				keys = {
					{
						"<leader>ci",
						"<cmd>InlayHintsToggle<cr>",
						desc = "Toggle inlay hints",
					},
				},
				opts = {
					commands = { enable = true },
					autocmd = { enable = true },
				},
			},
		},
		keys = {
			{
				"<leader>cä",
				function()
					vim.diagnostic.jump({ count = -1 })
				end,
				desc = "Diagnostics - previous",
			},
			{
				"<leader>cö",
				function()
					vim.diagnostic.jump({ count = 1 })
				end,
				desc = "Diagnostics - next",
			},
		},
		---@class PluginLspConfigOpts
		---@field capabilities lsp.ClientCapabilities
		---@field diagnostics vim.diagnostic.Opts
		---@field servers table<string, lspconfig.Config>
		opts = {
			capabilities = {
				workspace = {
					fileOperations = {
						didRename = true,
						willRename = true,
					},
				},
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			},
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					source = true,
				},
				severity_sort = true,
			},
			-- Language related servers are read from `config.lang`
			servers = {
				lua_ls = { enabled = true },
			},
		},
		---@param opts PluginLspConfigOpts
		config = function(_, opts)
			local config = require("plugins.lsp.config")

			-- Configure Vim diagnostics
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			-- Prepare LSP server list
			config.set_servers(opts.servers)

			-- Prepare capabilities
			config.set_global_capabilities(opts.capabilities)

			-- Automate `lspconfig` configuration with `lsp-zero`
			local has_lsp_zero, lsp_zero = pcall(require, "lsp-zero")
			local lsp_attach = function(client, bufnr)
				lsp_zero.highlight_symbol(client, bufnr)

				-- Buffer keymaps
				vim.keymap.set("n", "<leader>ca", function()
					vim.lsp.buf.code_action()
				end, { buffer = bufnr, desc = "Code action" })
				vim.keymap.set("n", "<leader>cF", function()
					vim.lsp.buf.format()
				end, { buffer = bufnr, desc = "Code format [LSP]" })
				vim.keymap.set("n", "<leader>cr", function()
					vim.lsp.buf.rename()
				end, { buffer = bufnr, desc = "Rename" })
				vim.keymap.set("n", "<leader>cK", function()
					vim.lsp.buf.hover()
				end, { buffer = bufnr, desc = "Hover [LSP]" })

				-- Codelens keymaps
				vim.keymap.set("n", "<leader>cl", function()
					vim.lsp.codelens.run()
				end, { buffer = bufnr, desc = "Codelens" })
				vim.keymap.set("n", "<leader>cL", function()
					vim.lsp.codelens.refresh()
				end, { buffer = bufnr, desc = "Codelens with refresh" })

				-- Jump keymaps
				vim.keymap.set("n", "<leader>jd", function()
					vim.lsp.buf.definition()
				end, { buffer = bufnr, desc = "Jump to definition" })
				vim.keymap.set("n", "<leader>jD", function()
					vim.lsp.buf.declaration()
				end, { buffer = bufnr, desc = "Jump to declaration" })
				vim.keymap.set("n", "<leader>jI", function()
					vim.lsp.buf.implementation()
				end, { buffer = bufnr, desc = "Jump to implementation" })
				vim.keymap.set("n", "<leader>jt", function()
					vim.lsp.buf.type_definition()
				end, { buffer = bufnr, desc = "Jump to type definition" })

				-- Inlay hints keymaps
				local has_inlay_hints, _ = pcall(require, "inlay-hints")
				if has_inlay_hints then
					vim.keymap.set(
						"n",
						"<leader>cH",
						"<cmd>InlayHintsToggle<cr>",
						{ buffer = bufnr, desc = "Toggle inlay hints" }
					)
				end
			end

			lsp_zero.extend_lspconfig({
				sign_text = true,
				lsp_attach = lsp_attach,
				capabilities = config.capabilities,
				float_border = "rounded",
			})

			-- Configure LSP servers via mason-lspconfig if available
			config.configure_mason()

			-- Configure LSP servers via lspconfig
			config.configure_servers()
		end,
	},
}

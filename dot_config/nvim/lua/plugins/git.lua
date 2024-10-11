return {
	{
		"lewis6991/gitsigns.nvim",
		version = "*",
		enabled = vim.fn.has("nvim-0.9.0") == 1,
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			linehl = false,
			max_file_length = 10000, -- Default: 40000
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				---@param mode string|string[]
				---@param lhs string
				---@param rhs string|function
				---@param opts vim.keymap.set.Opts
				local function map(mode, lhs, rhs, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, lhs, rhs, opts)
				end

				---@param lhs string
				---@param rhs string|function
				---@param desc string
				local function nmap(lhs, rhs, desc)
					map("n", lhs, rhs, { desc = desc })
				end

				-- Actions
				nmap("<leader>gu", gitsigns.undo_stage_hunk, "Undo stage hunk")
				nmap("<leader>gb", gitsigns.toggle_current_line_blame, "Toggle blame")
				nmap("<leader>gB", function()
					gitsigns.blame_line({ full = true })
				end, "Full line blame")
			end,
		},
	},
}

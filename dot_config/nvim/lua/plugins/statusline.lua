local function lint_progress()
  local has_lint, lint = pcall(require, "lint")
  if not has_lint then return "" end

  local linters = lint.get_running()
  if #linters == 0 then
      return ""
  end
  return "󱉶 " .. table.concat(linters, ", ")
end

return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			extensions = {
				"lazy",
				"trouble",
				"mason",
			},
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = true,
						path = 4,
						symbols = {
							unnamed = "[No Name]",
							newfile = "[New]",
							readonly = "[!]",
							modified = "[+]",
						},
					},
				},
				lualine_x = {
          {
            lint_progress,
            separator = "",
          },
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
					},
				},
				lualine_y = {
					{
						"filetype",
						icon_only = false,
						separator = "",
					},
					{
						"encoding",
						separator = "",
					},
					{
						"fileformat",
					},
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = { fg = "#ff9e64" },
					},
				},
				lualine_z = {
					{
						"progress",
						padding = { left = 1, right = 0 },
						separator = { left = "", right = "" },
					},
					{
						"location",
						padding = 0,
					},
				},
			},
		},
	},
}

local M = {}

local bin_paths_by_pkg_manager = {
	node = { "./node_modules/.bin" },
	composer = { "./vendor/bin" },
}

local bin_paths_by_filetype = {
	javascript = vim.tbl_extend("force", {}, bin_paths_by_pkg_manager.node),
	javascriptreact = vim.tbl_extend("force", {}, bin_paths_by_pkg_manager.node),
	typescript = vim.tbl_extend("force", {}, bin_paths_by_pkg_manager.node),
	typescriptreact = vim.tbl_extend("force", {}, bin_paths_by_pkg_manager.node),
}

---Returns filetype to rootmarkers mapper
---@return table<string, string[]>
function M.get_rootmarkers_by_language()
	local languages = require("config.lang")

	local filetype_to_rootmarkers = {} ---@type table<string, string[]>
	for _, language in ipairs(languages) do
		if type(language.rootMarkers) == "table" then
			for _, filetype in ipairs(language.filetypes) do
				if not vim.tbl_contains(filetype_to_rootmarkers, filetype) then
					filetype_to_rootmarkers[filetype] = language.rootMarkers
				else
					filetype_to_rootmarkers[filetype] =
						vim.tbl_extend("force", filetype_to_rootmarkers, language.rootMarkers)
				end
			end
		end
	end

	return filetype_to_rootmarkers
end

---Finds the executable path from current filepath upward,
---thus providing support for monorepos.
---
---Fallback is to provide the binary name for possible global executable.
---@param binary_name string
---@return string executable_path Path to the nearest executable or global executable.
function M.get_executable(binary_name)
	local dirname = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
	local filetype = vim.bo.filetype
	local filetype_bin_paths = bin_paths_by_filetype[filetype]

	if type(filetype_bin_paths) == "table" then
		for _, filetype_bin_path in ipairs(filetype_bin_paths) do
			local project_bin_paths = vim.fs.find(filetype_bin_path .. "/" .. binary_name, {
				upward = true,
				path = dirname,
			})

			for _, execpath in ipairs(project_bin_paths) do
				if vim.fn.executable(execpath) == 1 then
					return execpath
				end
			end
		end
	end

	return binary_name
end

return M

local language_list = require("config.lang")
local utils = require("utils")

local M = {}

---Provides package if found from Mason registry
---@param package_name any
---@return Package|nil
function M.get_mason_pkg_by_name(package_name)
  local mason_registry = require("mason-registry")
	local found, mason_package = pcall(mason_registry.get_package, package_name)
	if found then
		return mason_package
	else
		vim.notify(("[mason] unknown package '%s'"):format(package_name))
	end
end

---Installs provided list with Mason.
---@param mason_pkg Package
function M.install_with_mason(mason_pkg)
	if mason_pkg:is_installed() then
		return
	end

	vim.notify(("[mason] trying to install '%s'"):format(mason_pkg.name))
	mason_pkg:install():once(
		"closed",
		vim.schedule_wrap(function()
			if mason_pkg:is_installed() then
				vim.notify(("[mason] successfully installed '%s'"):format(mason_pkg.name))
			else
				vim.notify(("[mason] failed to install '%s'"):format(mason_pkg.name))
			end
		end)
	)
end

---Checks all configured languages and returns a list of enabled Mason linters.
---@return Package[]
function M.get_configured_mason_linters()
	local pkg_list = {}
	for _, language in ipairs(language_list) do
		if language.linting ~= nil and type(language.linting.install_with_mason) == "table" then
			pkg_list = utils.list_to_unique_list(language.linting.install_with_mason)
		end
	end

	local mason_pkg_list = {}
	for _, pkg in ipairs(pkg_list) do
		local mason_pkg = M.get_mason_pkg_by_name(pkg)
		if mason_pkg ~= nil then
			table.insert(mason_pkg_list, mason_pkg)
		end
	end

	return mason_pkg_list
end

---Checks all configured languages and returns a list of enabled Mason formatters.
---@return Package[]
function M.get_configured_mason_formatters()
	local pkg_list = {}
	for _, language in ipairs(language_list) do
		if language.formatting ~= nil and type(language.formatting.install_with_mason) == "table" then
			pkg_list = utils.list_to_unique_list(language.formatting.install_with_mason)
		end
	end

	local mason_pkg_list = {}
	for _, pkg in ipairs(pkg_list) do
		local mason_pkg = M.get_mason_pkg_by_name(pkg)
		if mason_pkg ~= nil then
			table.insert(mason_pkg_list, mason_pkg)
		end
	end

	return mason_pkg_list
end

---@return table<string, string[]>
function M.get_linters_by_ft()
	local linters_by_ft = {}

	for _, language in ipairs(language_list) do
		if language.linting ~= nil and type(language.filetypes) == "table" then
			for _, filetype in ipairs(language.filetypes) do
				-- Configure formatters for the filetype
				if type(language.linting.linters) == "table" then
					if not vim.tbl_contains(vim.tbl_keys(linters_by_ft), filetype) then
						linters_by_ft[filetype] = language.linting.linters
					else
						vim.tbl_deep_extend("error", linters_by_ft, { [filetype] = language.linting.linters })
					end
				end
			end
		end
	end

	return linters_by_ft
end

---@return table<string, conform.FiletypeFormatterInternal>
function M.get_formatters_by_ft()
	local formatters_by_ft = {}

	for _, language in ipairs(language_list) do
		if language.formatting ~= nil and type(language.filetypes) == "table" then
			for _, filetype in ipairs(language.filetypes) do
				-- Configure formatters for the filetype
				if type(language.formatting.formatters) == "table" then
					if not vim.tbl_contains(vim.tbl_keys(formatters_by_ft), filetype) then
						formatters_by_ft[filetype] = language.formatting.formatters
					else
						vim.tbl_deep_extend("error", formatters_by_ft, { [filetype] = language.formatting.formatters })
					end
				end
			end
		end
	end

	return formatters_by_ft
end

---@return {excluded_filetypes:string[], excluded_paths:string[]}
function M.get_autoformat_opts()
	local excluded_filetypes = {}
	local excluded_paths = {}

	for _, language in ipairs(language_list) do
		if language.formatting ~= nil and type(language.filetypes) == "table" then
			for _, filetype in ipairs(language.filetypes) do
				if language.formatting.format_on_save == false then
					table.insert(excluded_filetypes, filetype)
				end
			end

			if type(language.formatting.excluded_paths) == "table" then
				excluded_paths = vim.tbl_extend("force", excluded_paths, language.formatting.excluded_paths)
			end
		end
	end

	return {
		excluded_filetypes = utils.list_to_unique_list(excluded_filetypes),
		excluded_paths = excluded_paths,
	}
end

return M

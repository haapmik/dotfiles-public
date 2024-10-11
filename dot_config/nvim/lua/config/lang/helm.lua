---Checks if the file is located inside Helm chart folder.
---@param path string
---@return boolean
local function is_helm_file(path)
	local root_markers = { "Chart.yaml", "Chart.yml" }

	for _, marker in ipairs(root_markers) do
		local found = vim.fs.find(marker, { path = vim.fs.dirname(path), upward = true })

		if not vim.tbl_isempty(found) then
			return true
		end
	end
	return false
end

---Checks if the filetype should be marked as `helm` or `yaml`
---Treesitter's helm dialect support requires that the filetype is marked as `helm`.
---@param path string
---@param bufname any
---@return "helm"|"yaml"
local function helm_filetype(path, bufname)
	return is_helm_file(path) and "helm" or "yaml"
end

---Checks if the filetype should be marked as `helm` or `template`
---Treesitter's helm dialect support requires that the filetype is marked as `helm`.
---@param path string
---@param bufname any
---@return "helm"|"template"
local function tmpl_filetype(path, bufname)
	return is_helm_file(path) and "helm" or "template"
end

vim.filetype.add({
	extension = {
		yaml = helm_filetype,
		yml = helm_filetype,
		tmpl = tmpl_filetype,
		tpl = tmpl_filetype,
	},
	filename = {
		["Chart.yaml"] = "yaml",
		["Chart.lock"] = "yaml",
	},
})

---@type CustomLangConfig
return {
	filetypes = {
		"helm",
	},
	treesitter = {
		"helm",
		"yaml", -- Needed for Charts.yaml
	},
	linting = {
		linters = {
			"trivy_helm", -- custom linter for nvim-lint
		},
		install_with_mason = {
			"trivy",
		},
	},
	lspconfig = {
		servers = {
			helm_ls = {
				enabled = true,
				filetypes = {
					"helm",
				},
			},
			yamlls = {
				enabled = true, -- helm-ls will utilize yamlls to provide additional capabilities
			},
		},
	},
}

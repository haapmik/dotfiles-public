local severity_map = {
	["LOW"] = vim.diagnostic.severity.INFO,
	["MEDIUM"] = vim.diagnostic.severity.WARN,
	["HIGH"] = vim.diagnostic.severity.ERROR,
}

---@param filepath string
---@return string
local function get_chart_root_dir(filepath)
	local root_markers = { "Chart.yaml", "Chart.yml" }

  local found = vim.fs.find(root_markers, { path = vim.fs.dirname(filepath), upward = true })

  if not vim.tbl_isempty(found) then
    return vim.fs.dirname(found[1])
  end

	return "."
end

---@param sentence string
---@return string
local function add_period(sentence)
	if sentence:match("%.$") then
		return sentence
	end
	return sentence .. "."
end

---Formats misconfig message to human-readable.
---
---  Example:
---    {Title}: {Message}.
---    {Description}. {Resolution}.
---    See {PrimaryUrl}
---@param misconfig table
---@return string
local function format_message(misconfig)
	local message = misconfig.Title or ""

	if misconfig.Message ~= nil then
		message = string.format("%s: %s", message, add_period(misconfig.Message))
	end

	if misconfig.Description ~= nil then
		message = string.format("%s\n%s", message, add_period(misconfig.Description))
	end

	if misconfig.Resolution ~= nil then
		message = string.format("%s %s", message, add_period(misconfig.Resolution))
	end

	if misconfig.PrimaryURL ~= nil then
		message = string.format("%s\nSee %s", message, misconfig.PrimaryURL)
	end

	return message
end

---@param output string
---@param bufnr integer
---@return table
local function lint_parser(output, bufnr)
	local diagnostics = {}

	-- example output:
	-- {
	--   "Results": [
	--     "Target": "<file path from Chart.yaml>",
	--     "Misconfigurations": [
	--        {
	--          "ID": "<nvim-lint code>",
	--          "AVDID": "<nvim-lint code>",
	--          "Title": "<title>",
	--          "Description": "<description>",
	--          "Message": "<message>",
	--          "Severity": "<LOW|MEDIUM|HIGH>",
	--          "Resolution": "<resolution>",
	--          "PrimaryURL": "<guide url>",
	--          "CauseMetadata": {
	--            "StartLine": <line number>, <-- From compiled Helm chart and thus invalid
	--            "EndLine": <line number>, <-- From compiled Helm chart and thus invalid
	--          }
	--        }
	--     ]
	--   ]
	-- }
	--

	-- Get Helm chart root path
	local filepath = vim.api.nvim_buf_get_name(bufnr)
	local chartpath = get_chart_root_dir(filepath)

	local decoded = vim.json.decode(output)
	for _, result in ipairs(decoded and decoded.Results or {}) do
		-- trivy will return result related to all files in the chart
		for _, misconfig in ipairs(result.Misconfigurations or {}) do
			table.insert(diagnostics, {
				source = "trivy",
				message = format_message(misconfig),
				col = 0,
				end_col = 0,
				file = chartpath .. result.Target,
				lnum = 0,
				end_lnum = 0,
				code = misconfig.ID or misconfig.AVDID,
				severity = severity_map[misconfig.Severity] or vim.diagnostic.severity.WARN,
			})
		end
	end
	return diagnostics
end

---@return lint.Linter
local function get_linter()
	local has_lint_parser, _ = pcall(require, "lint.parser")

	if not has_lint_parser then
		return {}
	end

	local linter = require("lint").linters.trivy

  if type(linter) == "function" then
    linter = linter()
  end

	linter.args = { "--format", "json", "config", get_chart_root_dir(vim.api.nvim_buf_get_name(0)) }
	linter.append_fname = false
	linter.parser = lint_parser

	return linter
end

return get_linter()

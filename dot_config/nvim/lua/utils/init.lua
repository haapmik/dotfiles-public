local M = {}

---Makes a list an unique list.
---@param list string[]
---@return string[]
function M.list_to_unique_list(list)
	local unique_list = {}
	for _, item in ipairs(list) do
		if item ~= nil and not vim.tbl_contains(unique_list, item) then
			table.insert(unique_list, item)
		end
	end
	return unique_list
end

return M

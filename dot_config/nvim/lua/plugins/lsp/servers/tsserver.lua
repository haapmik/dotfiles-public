local M = {}

local default_inlayhints = {
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = false,
	includeInlayVariableTypeHintsWhenTypeMatchesName = false,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}

M.settings = {
	typescript = {
		inlayHints = default_inlayhints,
	},
	javascript = {
		inlayHints = default_inlayhints,
	},
}

return M

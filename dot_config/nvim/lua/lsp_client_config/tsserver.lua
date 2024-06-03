-- @see https://github.com/typescript-language-server/typescript-language-server#initializationoptions
local server_default_preferences = {
  allowIncompleteCompletions = true,
  allowRenameOfImportPath = true,
  allowTextChangesInNewFiles = true,
  displayPartsForJSDoc = true,
  generateReturnInDocTemplate = true,
  includeAutomaticOptionalChainCompletions = true,
  includeCompletionsForImportStatements = true,
  includeCompletionsForModuleExports = true,
  includeCompletionsWithClassMemberSnippets = true,
  includeCompletionsWithObjectLiteralMethodSnippets = true,
  includeCompletionsWithInsertText = true,
  includeCompletionsWithSnippetText = true,
  jsxAttributeCompletionStyle = "auto",
  providePrefixAndSuffixTextForRename = true,
  provideRefactorNotApplicableReason = true,
}

local inlay_hints = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

local M = {
  init_options = {
    hostInfo = "neovim",
    preferences = vim.tbl_extend("force", server_default_preferences, {
      importModuleSpecifierEnding = "auto",
      includeCompletionsForModuleExports = true,
      includeCompletionsWithInsertText = true,
      quotePreference = "auto",
      useLabelDetailsInCompletionEntries = true,
    }),
  },
  settings = {
    completions = {
      completeFunctionCalls = false,
    },
    typesscript = {
      inlayHints = inlay_hints,
    },
    javascript = {
      inlayHints = inlay_hints,
    },
  },
}

return M

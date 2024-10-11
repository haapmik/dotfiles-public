---Provides virtual text for folded lines.
---@param virtText table
---@param lnum number
---@param endLnum number
---@param width number
---@param truncate boolean
---@return table
local fold_virt_text_provider = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" … %d lines"):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

local filetypeMap = {
  git = "",
}

return {
  {
    "kevinhwang91/nvim-ufo",
    --version = "*",
    version = false, -- 2024-07-21: latest version is from April 3 2024 which doesn't include deprecation fixes
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "VeryLazy",
    config = function(_, opts)
      vim.opt.foldcolumn = "1"
      vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true
      vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      local ufo = require("ufo")

      ---@diagnostic disable-next-line: missing-fields
      ufo.setup({
        fold_virt_text_handler = fold_virt_text_provider,
        provider_selector = function(bufnr, filetype, buftype)
          return filetypeMap[filetype] or { "lsp", "indent" }
        end,
      })

      -- We need to replace original fold related keymaps with ufo's
      vim.keymap.set("n", "zR", ufo.openAllFolds)
      vim.keymap.set("n", "zM", ufo.closeAllFolds)
      vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
      vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    end,
  },
}

---Configures given folding method
---@param method
---| "treesitter"
---| "manual"
---| "indent"
---| "marker"
---| "syntax"
---| "diff"
local function set_folding_method(method)
  if method == "treesitter" then
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  elseif method == "manual" or "indent" or "marker" or "syntax" or "diff" then
    vim.opt.foldmethod = method
  end
end

local function configure_folding()
  vim.opt.foldenable = true
  vim.opt.foldcolumn = "auto"

  set_folding_method("treesitter")

  vim.opt.foldlevel = 2
  vim.opt.foldlevelstart = 2
  vim.opt.foldminlines = 2
  vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
end

--- Enables better fold search logic.
--- Based on https://nanotipsforvim.prose.sh/better-folding-%28part-1%29--pause-folds-while-searching
local function enable_better_fold_search()
  -- Prevent default fold auto-opening behaviour
  vim.opt.foldopen:remove({ "search" })

  local create_namespace = vim.api.nvim_create_namespace
  local namespace_name = create_namespace("FoldsPauseOnSearch")

  vim.keymap.set("n", "/", "zn/", { desc = "Search with folded content" })
  vim.on_key(function(char)
    local used_key = vim.fn.keytrans(char)
    local search_key_list = { "n", "N", "*", "#", "/", "?" }

    local search_confirm_status = string.upper(used_key) == "<CR>" and vim.fn.getcmdtype():find("[/?]") ~= nil

    -- Must be in correct mode with search confirmed
    if not (search_confirm_status or vim.fn.mode() == "n") then
      return
    end

    local search_key_used = search_confirm_status or search_key_list[used_key] ~= nil
    local folding_enabled = vim.opt.foldenable:get()

    -- Set fold state according to search state
    if folding_enabled and search_key_used then
      vim.opt.foldenable = false
    elseif not folding_enabled and not search_key_used then
      vim.opt.foldenable = true
    end
  end, namespace_name)
end

local function reload_treesitter()
  -- Reload treesitter to fix possible highlighting issues
  -- https://github.com/nvim-treesitter/nvim-treesitter/issues/78
  vim.cmd("edit | TSBufEnable highlight")

  -- Treesitter folding is experimental and sometimes breaks.
  -- This will automatically reload folds for the current buffer.
  vim.cmd.normal("zx")
end

--- Enables persisted folds across sessions.
--- Based on https://nanotipsforvim.prose.sh/better-folding-%28part-3%29--remember-your-folds-across-sessions
local function enable_persisted_folds()
  local ignore = {
    filetype = {
      "TelescopePrompt",
      "gitcommit",
      "help",
      "Outline",
      "Trouble",
    },
    buftype = nil,
  }

  -- Skip ignored filetypes
  if ignore.filetype[vim.bo.filetype] ~= nil then
    return
  end

  -- Skip ignored buftype or all buftypes if undefined
  if ignore.buftype == nil and vim.bo.buftype ~= "" then
    return
  elseif ignore.buftype ~= nil and ignore.buftype[vim.bo.buftype] ~= nil then
    return
  end

  -- Skip unmodifiable files
  if not vim.bo.modifiable then
    return
  end

  local create_augroup = vim.api.nvim_create_augroup
  local create_autocmd = vim.api.nvim_create_autocmd
  local augroup_name = create_augroup("FoldsPresisted", { clear = true })

  -- Saving
  create_autocmd({ "BufWinLeave" }, {
    group = augroup_name,
    pattern = "?*",
    callback = function()
      vim.cmd.mkview()
    end,
  })

  -- Loading
  create_autocmd({ "BufWinEnter" }, {
    group = augroup_name,
    pattern = "?*",
    callback = function()
      vim.cmd.loadview({ mods = { emsg_silent = true } })
    end,
  })

  local treesitter_folds_enabled = string.match(vim.opt.foldexpr:get(), "treesitter")
      and vim.opt.foldmethod:get() == "expr"

  -- Fix Treesitter folds disappearing after save
  if treesitter_folds_enabled then
    create_autocmd({ "BufWritePre" }, {
      group = augroup_name,
      pattern = "?*",
      callback = function()
        vim.cmd.mkview()
      end,
    })

    create_autocmd({ "BufWritePost" }, {
      group = augroup_name,
      pattern = "?*",
      callback = function()
        reload_treesitter()
        vim.cmd.loadview({ mods = { emsg_silent = true } })
      end,
    })
  end
end

configure_folding()
enable_better_fold_search()
enable_persisted_folds()

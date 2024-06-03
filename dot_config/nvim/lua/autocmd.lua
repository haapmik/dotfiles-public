local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function autocmd_create_dir()
  -- Auto create dir when saving a file, in case some intermediate directory does not exist
  -- based on https://github.com/NickP-real/.dotfile/tree/main
  autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir", { clear = true }),
    callback = function(event)
      if event.match:match("^%w%w+://") then
        return
      end
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
  })
end

local function autocmd_python()
  autocmd({ "FileType" }, {
    pattern = "python",
    callback = function(opts)
      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.autoindent = true
    end,
  })
end

local function autocmd_typescript()
  autocmd({ "FileType" }, {
    pattern = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    callback = function(opts)
      vim.opt.autoindent = true
      vim.opt.breakindent = true
      vim.opt.smartindent = true
      vim.opt.expandtab = true
      vim.opt.smarttab = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
    end,
  })
end

local function autocmd_helm()
  autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
      "*/templates/*.yaml",
      "*/templates/*.yml",
      "*/templates/*.tpl",
    },
    callback = function(opts)
      vim.opt_local.filetype = "helm"
    end,
  })
end

local function autocmd_plantuml()
  autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
      "*.uml",
      "*.pu",
      "*.plantuml",
      "*.puml",
    },
    callback = function(opts)
      vim.opt_local.filetype = "plantuml"
    end,
  })
end

--autocmd_create_dir()
autocmd_helm()
autocmd_plantuml()
autocmd_python()
autocmd_typescript()

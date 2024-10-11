local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Automatically creates required directories when saving a file.
local function autocmd_create_dir()
  autocmd({ "BufWritePre" }, {
    desc = "Create missing directories when saving a file",
    group = augroup("auto_create_dir", { clear = true }),
    callback = function(event)
      if event.match:match("^%w%w+://") then
        return
      end
      local file = (vim.uv or vim.loop).fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end
  })
end

autocmd_create_dir()

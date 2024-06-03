-- Leader key mapping must be done before lazy
vim.g.mapleader = "å"

-- Load base configs
require("base")
--require("folding")
require("autocmd")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Enable experimental lua-loader
vim.loader.enable()

-- Load plugins
require("lazy").setup("plugins", {
  defaults = { lazy = true },
})

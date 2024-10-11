-- Default workdir for Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap lazy.nvim
-- NOTE: `vim.loop` has been deprecated in-favor of `vim.uv`
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local branch = "stable"
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=" .. branch,
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	defaults = {
		lazy = true, -- should plugins be lazy-loaded?
		version = "*", -- always use the version
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = {
		missing = true, -- install missing plugins on startup
		colorscheme = { "kanagawa" },
	},
	checker = {
		enabled = true, -- automatically check for plugin updates
		notify = false, -- get a notification when new updates are found
	},
  ui = {
    border = "single",
  },
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				-- "gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				-- "tarPlugin",
				-- "tohtml",
				-- "tutor",
				-- "zipPlugin",
			},
		},
	},
	profiling = {
		loader = true, -- Enable extra stats on the debug tab related to the loader cache
		require = true, -- Track each new require in the lazy profiling tab
	},
})

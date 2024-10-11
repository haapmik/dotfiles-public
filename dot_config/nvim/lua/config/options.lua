vim.g.mapleader = "å"

vim.opt.mousemoveevent = true
vim.opt.updatetime = 300

-- GUI
vim.opt.autochdir = true -- change dir according to active buffer
vim.opt.cmdheight = 2
vim.opt.cursorline = true -- cursor line highlight
vim.opt.mouse = "a" -- mouse mode
vim.opt.number = true -- line numbers
vim.opt.termguicolors = true -- enable truecolors
vim.opt.winminwidth = 10
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.scrolloff = 5
vim.opt.listchars:append({
	tab = "¬ ",
	eol = "↲",
	trail = "·",
	multispace = "·",
	extends = "❯",
	precedes = "❮",
})

-- Formatting
vim.opt.formatoptions = vim.opt.formatoptions
	- "t" -- Auto-wrap text using `textwidth`
	+ "c" -- Auto-wrap comments using `textwidth`
	+ "r" -- Continue comment when pressing enter in insert mode
	- "o" -- Continue comment with `o` or `O` in normal mode
	+ "q" -- Auto formatting for comments with "gq"
	- "a" -- Auto formatting for code and text
	+ "n" -- Auto formatting with lists using `formatlistpat`
	- "2" -- Indent first line of a paragraph
	+ "j" -- Remove comments when needed, e.g. when joining lines

-- Spelling
vim.opt.spell = false
vim.opt.spelllang = { "en" }

-- Undo
vim.opt.undofile = true
--vim.opt.undolevels = 100
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Swap
vim.opt.swapfile = false
vim.opt.directory = vim.fn.stdpath("state") .. "/swap"

-- Backup
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"

-- View
vim.opt.viewdir = vim.fn.stdpath("state") .. "/view"

-- Line wrapping
vim.opt.linebreak = true -- line break between words
vim.opt.showbreak = "+++"
vim.opt.breakindent = true -- line breaks continues visually indented

-- Indentation
-- Only one of the four can be enabled:
--   - `autoindent`,
--   - `smartindent`,
--   - `cindent`, and
--   - `indentexpr`.
--vim.opt.autoindent = true -- uses previous line information
vim.opt.smartindent = true -- recognizes syntax related rules
--vim.opt.cindent = true -- configurable indentation style'
--vim.opt.indentexpr = nil

vim.opt.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
vim.opt.shiftround = true
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.tabstop = 2 -- number of spaces tabs count for

-- Misc
vim.opt.virtualedit = "block"
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.g.matchparen_timeout = 20 -- ms
vim.g.matchparen_insert_timeout = 20 -- ms

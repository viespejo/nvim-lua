vim.opt.backup = false -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.path = ",.**" -- |:find|, |:sfind|, |:tabfind| and other commands
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.list = true
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.softtabstop = 2 -- number of spaces that a <Tab> counts for while performing editing operations
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.breakindent = true -- every wrapped line will continue visually indented
vim.opt.showbreak = "↳ " -- string to put at the start of lines that have been wrapped
vim.opt.hidden = true -- allow switching buffers without writting to disk
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case
vim.opt.colorcolumn = "80" -- column highlighted
vim.opt.number = true -- set numbered lines
vim.opt.numberwidth = 4
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1200 -- time to wait for a mapped sequence to complete (in milliseconds)
-- vim.opt.ttimeout = true -- time to wait for a key code sequence to complete
-- vim.opt.ttimeoutlen = 0 -- time to wait for a key code sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.tags = "./tags;/" -- ctag
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
-- vim.opt.pumblend = 10
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.swapfile = false -- creates a swapfile
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.cursorline = true -- highlight the current line
vim.opt.wrap = false -- display lines as one long line
vim.opt.sidescrolloff = 8
vim.opt.shada = [['50,<50,s10,h,/100]] -- shada options
vim.opt.listchars = { -- strings to use in list mode
	tab = "→.",
	trail = "·",
	eol = "¬",
	extends = "…",
	precedes = "…",
}
vim.opt.shortmess:append("c") -- default vertical split for diff mode
vim.opt.diffopt:append("vertical") -- default vertical split for diff mode
vim.opt.spelllang = "en_us" -- set spell language
vim.opt.spell = true -- enable spell checking

local terminalG = vim.api.nvim_create_augroup("vec_terminal", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen" }, {
	group = terminalG,
	callback = function()
		vim.cmd("setlocal scl=no nonumber")
	end,
})

local formatOptionsG = vim.api.nvim_create_augroup("vec_formatoptions", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = formatOptionsG,
	callback = function()
		vim.cmd("set fo-=r fo-=o")
	end,
})

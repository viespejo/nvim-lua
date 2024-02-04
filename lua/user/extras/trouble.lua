local M = {
	"folke/trouble.nvim",
}

function M.config()
	vim.keymap.set(
		"n",
		"<Space>tt",
		":TroubleToggle document_diagnostics<cr>",
		{ noremap = true, silent = true, desc = "Trouble" }
	)
	vim.keymap.set(
		"n",
		"<Space>tT",
		":TroubleToggle workspace_diagnostics<cr>",
		{ noremap = true, silent = true, desc = "Trouble" }
	)
	vim.cmd([[au FileType Trouble setlocal statusline=\ \ Trouble]])
end

return M

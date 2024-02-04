local M = {
	"tpope/vim-dadbod",
	dependencies = {
		{
			"kristijanhusak/vim-dadbod-ui",
		},
	},
	cmd = "DBUI",
}

function M.config()
	vim.g.db_ui_execute_on_save = 0
	vim.cmd([[autocmd FileType dbout setlocal nofoldenable]])
end

return M

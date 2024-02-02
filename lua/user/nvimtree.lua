local M = {
	"nvim-tree/nvim-tree.lua",
	event = "VeryLazy",
}

function M.config()
	require("nvim-tree").setup({
		-- on_attach = my_on_attach,
		hijack_netrw = false,
		view = {
			width = {},
		},
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		update_focused_file = {
			enable = true,
			-- update_cwd = false,
			-- ignore_list = {},
		},
		renderer = {
			root_folder_label = function(path)
				path = vim.fn.fnamemodify(path, ":~")
				local parent_path = vim.fn.fnamemodify(path, ":h")
				local last_dir = vim.fn.fnamemodify(path, ":t")
				return parent_path:gsub("([a-zA-Z])[a-z]+", "%1") .. "/" .. last_dir
			end,
			indent_markers = {
				enable = true,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					none = " ",
				},
			},
		},
	})

	-- vim.api.nvim_create_autocmd("BufEnter", {
	-- 	nested = true,
	-- 	callback = function()
	-- 		if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
	-- 			vim.cmd("quit")
	-- 		end
	-- 	end,
	-- })

	-- vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#1a1b26" })
	-- vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { bg = "#1a1b26", fg = "#1a1b26" })
	vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#f7768e", bold = true })
end

return M

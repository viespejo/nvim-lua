local M = {
	"supermaven-inc/supermaven-nvim",
	event = "VeryLazy",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<C-l>",
				clear_suggestion = "<C-e>",
				accept_word = "<C-k>",
			},
			ignore_filetypes = {
				help = true,
				gitrebase = true,
				cvs = true,
				["."] = false,
			},
			log_level = "off",
		})
	end,
}

return M

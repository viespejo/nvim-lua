local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	dependencies = {
		"zbirenbaum/copilot-cmp",
	},
}

function M.config()
	require("copilot").setup({
		panel = {
			enabled = true,
			auto_refresh = false,
		},
		suggestion = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept = "<c-l>",
				next = "<c-j>",
				-- dismiss = "<c-h>",
				prev = "<c-k>",
				dismiss = "<c-e>",
			},
		},
		filetypes = {
			markdown = true,
			help = false,
			gitcommit = true,
			gitrebase = false,
			cvs = false,
			yaml = true,
			["."] = false,
		},
		copilot_node_command = "node",
	})

	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap("n", "<c-s>", ":lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)

	-- require("copilot_cmp").setup()
end

return M

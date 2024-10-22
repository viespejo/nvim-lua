local M = {
	"joshuavial/aider.nvim",
	event = "VeryLazy",
}

function M.config()
	require("aider").setup({
		auto_manage_context = false,
		default_bindings = false,
	})
	-- set a keybinding for the AiderOpen function
	vim.api.nvim_set_keymap("n", "<leader>ao", "<cmd>lua AiderOpen()<cr>", { noremap = true, silent = true })
end

return M

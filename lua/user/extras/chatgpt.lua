local M = {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	config = function()
		require("chatgpt").setup()
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
}

function M.config()
	local home = vim.fn.expand("$HOME")
	require("chatgpt").setup({
		-- api_key_cmd = "gpg --decrypt " .. home .. "/api-key-chatgpt.gpg",
		predefined_chat_gpt_prompts = "file:///" .. vim.fn.stdpath("config") .. "/chatgpt-prompts.csv",
	})
end

return M

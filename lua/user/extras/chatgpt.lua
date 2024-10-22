local M = {
	"jackMort/ChatGPT.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<leader>Cc", "<cmd>ChatGPT<cr>", mode = "n", desc = "ChatGPT" },
		{ "<leader>CC", "<cmd>ChatGPTCompleteCode<cr>", mode = "n", desc = "ChatGPT Complete Code" },
		{ "<leader>Ca", "<cmd>ChatGPTActAs<cr>", mode = "n", desc = "ChatGPT Act As" },
		{
			"<leader>Ce",
			"<cmd>ChatGPTEditWithInstruction<cr>",
			mode = { "n", "v" },
			desc = "ChatGPT Edit With Instruction",
		},
		{ "<leader>Ct", "<cmd>ChatGPTRun translate<cr>", mode = { "n", "v" }, desc = "ChatGPT Translate" },
		{ "<leader>Cs", "<cmd>ChatGPTRun summarize<cr>", mode = { "n", "v" }, desc = "ChatGPT Summarize" },
		{
			"<leader>Cg",
			"<cmd>ChatGPTRun grammar_correction<cr>",
			mode = { "n", "v" },
			desc = "ChatGPT Grammar Correction",
		},
		{ "<leader>Co", "<cmd>ChatGPTRun optimize_code<cr>", mode = { "n", "v" }, desc = "ChatGPT Optimize Code" },
		{ "<leader>Cx", "<cmd>ChatGPTRun explain_code<cr>", mode = { "n", "v" }, desc = "ChatGPT Explain Code" },
	},
}

function M.config()
	local home = vim.fn.expand("$HOME")
	require("chatgpt").setup({
		openai_params = {
			model = "gpt-4o-mini",
			frequency_penalty = 0,
			presence_penalty = 0,
			max_tokens = 300,
			temperature = 0,
			top_p = 1,
			n = 1,
		},
		openai_edit_params = {
			model = "gpt-4o-mini",
			frequency_penalty = 0,
			presence_penalty = 0,
			temperature = 0,
			top_p = 1,
			n = 1,
		},
		-- api_key_cmd = "gpg --decrypt " .. home .. "/api-key-chatgpt.gpg",
		predefined_chat_gpt_prompts = "file:///" .. vim.fn.stdpath("config") .. "/chatgpt-prompts.csv",
	})
end

return M

local prompts = {
	-- Code related prompts
	Explain = "Please explain how the following code works.",
	Review = "Please review the following code and provide suggestions for improvement.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
	Refactor = "Please refactor the following code to improve its clarity and readability.",
	FixCode = "Please fix the following code to make it work as intended.",
	FixError = "Please explain the error in the following text and provide a solution.",
	BetterNamings = "Please provide better names for the following variables and functions.",
	Documentation = "Please provide documentation for the following code.",
	SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
	SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
	-- Text related prompts
	Summarize = "Please summarize the following text.",
	Spelling = "Please correct any grammar and spelling errors in the following text.",
	Wording = "Please improve the grammar and wording of the following text.",
	Concise = "Please rewrite the following text to make it more concise.",
}

local M = {
	"CopilotC-Nvim/CopilotChat.nvim",
	event = "VeryLazy",
	branch = "canary",
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	},
	build = "make tiktoken", -- Only on MacOS or Linux
	opts = {
		-- debug = true,
		model = "gpt-4o", -- GPT model to use, 'gpt-3.5-turbo', 'gpt-4', or 'gpt-4o'
		temperature = 0, -- GPT temperature
		prompts = prompts,
		show_help = true, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
	},
	keys = {
		-- Show help actions
		{
			"<leader>ih",
			function()
				local actions = require("CopilotChat.actions")
				require("CopilotChat.integrations.fzflua").pick(actions.help_actions())
			end,
			desc = "CopilotChat - Help actions",
		},
		-- Show prompts actions
		{
			"<leader>ip",
			function()
				local actions = require("CopilotChat.actions")
				require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
			end,
			desc = "CopilotChat - Prompt actions",
		},
		{
			"<leader>ip",
			":lua require('CopilotChat.integrations.fzflua').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
			mode = "x",
			desc = "CopilotChat - Prompt actions",
		},
		-- Code related commands
		{ "<leader>ie", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
		{ "<leader>it", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
		{ "<leader>ir", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
		{ "<leader>iR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
		{ "<leader>in", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
		-- Chat with Copilot in visual mode
		{
			"<leader>iv",
			":CopilotChatVisual",
			mode = "x",
			desc = "CopilotChat - Open in vertical split",
		},
		{
			"<leader>ix",
			":CopilotChatInline<cr>",
			mode = "x",
			desc = "CopilotChat - Inline chat",
		},
		-- Custom input for CopilotChat
		{
			"<leader>ii",
			function()
				local input = vim.fn.input("Ask Copilot: ")
				if input ~= "" then
					vim.cmd("CopilotChat " .. input)
				end
			end,
			desc = "CopilotChat - Ask input",
		},
		-- Generate commit message based on the git diff
		{
			"<leader>im",
			"<cmd>CopilotChatCommit<cr>",
			desc = "CopilotChat - Generate commit message for all changes",
		},
		{
			"<leader>iM",
			"<cmd>CopilotChatCommitStaged<cr>",
			desc = "CopilotChat - Generate commit message for staged changes",
		},
		-- Quick chat with Copilot
		{
			"<leader>iq",
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					vim.cmd("CopilotChatBuffer " .. input)
				end
			end,
			desc = "CopilotChat - Quick chat",
		},
		-- Debug
		{ "<leader>id", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
		-- Fix the issue with diagnostic
		{ "<leader>if", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
		-- Clear buffer and chat history
		{ "<leader>il", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
		-- Toggle Copilot Chat Vsplit
		{ "<leader>iv", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
		-- Copilot Chat Models
		{ "<leader>i?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
	},
}

function M.config(_, opts)
	local chat = require("CopilotChat")
	local select = require("CopilotChat.select")
	-- Use unnamed register for the selection
	-- opts.selection = select.unnamed

	local user = vim.env.USER or "User"
	user = user:sub(1, 1):upper() .. user:sub(2)
	opts.question_header = "  " .. user .. " "
	opts.answer_header = "  Copilot "
	-- Override the git prompts message
	opts.prompts.Commit = {
		prompt = 'Write commit message with commitizen convention. Write clear, informative commit messages that explain the "what" and "why" behind changes, not just the "how".',
		selection = select.gitdiff,
	}
	opts.prompts.CommitStaged = {
		prompt = 'Write commit message for the change with commitizen convention. Write clear, informative commit messages that explain the "what" and "why" behind changes, not just the "how".',
		selection = function(source)
			return select.gitdiff(source, true)
		end,
	}

	chat.setup(opts)

	vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
		chat.ask(args.args, { selection = select.visual })
	end, { nargs = "*", range = true })

	-- Inline chat with Copilot
	vim.api.nvim_create_user_command("CopilotChatInline", function(args)
		chat.ask(args.args, {
			selection = select.visual,
			window = {
				layout = "float",
				relative = "cursor",
				width = 1,
				height = 0.4,
				row = 1,
			},
		})
	end, { nargs = "*", range = true })

	-- Restore CopilotChatBuffer
	vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
		chat.ask(args.args, { selection = select.buffer })
	end, { nargs = "*", range = true })

	-- Custom buffer for CopilotChat
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "copilot-*",
		callback = function()
			-- Get current filetype and set it to markdown if the current filetype is copilot-chat
			local ft = vim.bo.filetype
			if ft == "copilot-chat" then
				vim.bo.filetype = "markdown"
			end
		end,
	})
end

return M

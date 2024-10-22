local M = {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = "CodeCompanionChat",
	keys = {
		{ "<leader>ao", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Toggle" },
		{ "<leader>aa", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "CodeCompanion" },
	},
}

function M.config()
	local fmt = string.format
	require("codecompanion").setup({
		strategies = {
			chat = {
				adapter = "anthropic",
				slash_commands = {
					["buffer"] = {
						opts = {
							provider = "fzf_lua",
						},
					},
					["file"] = {
						opts = {
							provider = "fzf_lua",
						},
					},
				},
				roles = {
					llm = "CodeCompanion", -- The markdown header content for the LLM's responses
					user = "VEC", -- The markdown header for your questions
				},
			},
			inline = {
				adapter = "anthropic",
			},
			agent = {
				adapter = "anthropic",
			},
		},
		prompt_library = {
			["Explain"] = {
				opts = {
					auto_submit = false,
				},
			},
			["Fix code"] = {
				opts = {
					auto_submit = false,
				},
			},
			["Unit Tests"] = {
				opts = {
					auto_submit = false,
				},
			},
			["Generate a Commit Message"] = {
				opts = {
					auto_submit = false,
				},
			},
			["Generate a Commit Message (no staged)"] = {
				strategy = "chat",
				description = "Generate a commit message",
				opts = {
					index = 10,
					is_default = true,
					is_slash_cmd = true,
					short_name = "commit_no_staged",
					auto_submit = false,
				},
				prompts = {
					{
						role = "user",
						content = function()
							return fmt(
								[[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
%s
```
]],
								vim.fn.system("git diff")
							)
						end,
						opts = {
							contains_code = true,
						},
					},
				},
			},
		},
		display = {
			chat = {
				show_settings = false, -- Show LLM settings at the top of the chat buffer?
			},
			inline = {
				-- If the inline prompt creates a new buffer, how should we display this?
				layout = "buffer", -- vertical|horizontal|buffer
			},
		},
		-- GENERAL OPTIONS ----------------------------------------------------------
		opts = {
			log_level = "DEBUG", -- TRACE|DEBUG|ERROR|INFO
		},
	})

	local opts = { noremap = true, silent = true, desc = "CodeCompanion" }
	vim.api.nvim_set_keymap("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>", opts)
	vim.api.nvim_set_keymap("v", "<leader>aa", "<cmd>CodeCompanionActions<cr>", opts)
	vim.api.nvim_set_keymap("n", "<leader>ao", "<cmd>CodeCompanionChat Toggle<cr>", opts)
	vim.api.nvim_set_keymap("v", "<leader>ai", "<cmd>CodeCompanionChat Add<cr>", opts)

	-- Expand 'cc' into 'CodeCompanion' in the command line
	vim.cmd([[cab cc CodeCompanion]])
end

return M

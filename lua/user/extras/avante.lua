local M = {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- set this if you want to always pull the latest change
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		-- "zbirenbaum/copilot.lua", -- for providers='copilot'
		-- {
		-- 	-- support for image pasting
		-- 	"HakonHarnes/img-clip.nvim",
		-- 	event = "VeryLazy",
		-- 	opts = {
		-- 		-- recommended settings
		-- 		default = {
		-- 			embed_image_as_base64 = false,
		-- 			prompt_for_file_name = false,
		-- 			drag_and_drop = {
		-- 				insert_mode = true,
		-- 			},
		-- 			-- required for Windows users
		-- 			use_absolute_path = true,
		-- 		},
		-- 	},
		-- },
		-- {
		-- 	-- Make sure to set this up properly if you have lazy=true
		-- 	"MeanderingProgrammer/render-markdown.nvim",
		-- 	opts = {
		-- 		-- file_types = { "markdown", "Avante" },
		-- 		file_types = { "Avante" },
		-- 	},
		-- 	-- ft = { "markdown", "Avante" },
		-- 	ft = { "Avante" },
		-- },
	},
	opts = {
		---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
		-- provider = "claude",
		provider = "copilot",
		hints = { enabled = false },
		-- mappings = {
		-- 	ask = "<leader>aa", -- ask
		-- 	edit = "<leader>ae", -- edit
		-- 	refresh = "<leader>ar", -- refresh
		-- },
	},
	config = function(_, opts)
		require("avante_lib").load()
		require("avante").setup(opts)
	end,
}

return M
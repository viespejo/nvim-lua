local M = {
	"rest-nvim/rest.nvim",
	ft = "http",
	dependencies = {
		{
			"vhyrro/luarocks.nvim",
			priority = 1000,
			config = true,
			opts = {
				rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
			},
		},
		"luarocks.nvim",
	},
}

function M.config()
	require("rest-nvim").setup({
		keybinds = {
			{
				"<localleader>rr",
				"<cmd>Rest run<cr>",
				"Run request under the cursor",
			},
			{
				"<localleader>rl",
				"<cmd>Rest run last<cr>",
				"Re-run latest request",
			},
		},
	})
end

return M

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
	keys = {
		{ "<leader>rr", "<cmd>Rest run<cr>", desc = "Run REST request" },
		{ "<leader>rl", "<cmd>Rest last<cr>", desc = "Re-run last REST request" },
	},
}

function M.config()
	require("rest-nvim").setup()
end

return M

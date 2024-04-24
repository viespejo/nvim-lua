local M = {
	"marilari88/twoslash-queries.nvim",
	event = "VeryLazy",
}

function M.config()
	require("twoslash-queries").setup({
		multi_line = true, -- to print types in multi line mode
		is_enabled = false, -- to keep disabled at startup and enable it on request with the TwoslashQueriesEnable
		highlight = "Type", -- to set up a highlight group for the virtual text
	})
end

return M

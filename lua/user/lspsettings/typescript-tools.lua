return {
	-- disable_diagnostics = true,
	custom_on_attach = function(on_attach)
		return function(client, bufnr)
			on_attach(client, bufnr)

			vim.api.nvim_buf_set_keymap(
				bufnr,
				"n",
				"gs",
				"<cmd>TSToolsGoToSourceDefinition<cr>",
				{ noremap = true, silent = true }
			)

			-- check two-shlash plugin is installed
			local ok, twoslash = pcall(require, "twoslash-queries")
			if ok then
				twoslash.attach(client, bufnr)
				vim.keymap.set("n", "<leader>kk", "<cmd>TwoslashQueriesInspect<cr>", {})
			end
		end
	end,
}

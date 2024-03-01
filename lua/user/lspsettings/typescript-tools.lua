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
		end
	end,
}

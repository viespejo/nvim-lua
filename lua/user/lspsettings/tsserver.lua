return {
	-- disable_diagnostics = true,
	custom_on_attach = function(on_attach)
		return function(client, bufnr)
			on_attach(client, bufnr)

			-- we use null-ls for diagnostic and formatting (esling and prettier)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			-- this only stops displaying the diagnostics but continues to receive them from the server
			-- vim.diagnostic.disable(bufnr, vim.lsp.diagnostic.get_namespace(client.id))

			-- check two-shlash plugin is installed
			local ok, twoslash = pcall(require, "twoslash-queries")
			if ok then
				twoslash.attach(client, bufnr)
				vim.keymap.set("n", "<leader>k", "<cmd>TwoslashQueriesInspect<cr>", {})
			end
		end
	end,
}

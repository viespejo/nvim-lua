local M = {
	"nvimtools/none-ls.nvim",
	dependencies = {
		{
			"jose-elias-alvarez/typescript.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
}

function M.config()
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local code_actions = null_ls.builtins.code_actions
	local u = require("null-ls.utils")

	null_ls.setup({
		debug = false,
		sources = {
			diagnostics.golangci_lint,
			formatting.goimports,
			formatting.prettier.with({
				-- extra_args = function(params)
				--   local filetype = vim.api.nvim_buf_get_option(params.bufnr, "filetype")
				--
				--   local filetypes = {
				--     javascript = true,
				--     javascriptreact = true,
				--     typescript = true,
				--     typescriptreact = true,
				--   }
				--
				--   if filetypes[filetype] then
				--   	return { "--parser", "typescript" }
				--   end
				--
				--   return {}
				-- end,
				prefer_local = "node_modules/.bin",
			}),
			formatting.black,
			diagnostics.flake8.with({
				extra_args = { "--ignore=E501,E203" },
				filetypes = { "python" },
			}),
			-- formatting.yapf,
			formatting.stylua,
			diagnostics.stylelint,
			formatting.stylelint,
			diagnostics.eslint,
			code_actions.eslint,
			require("typescript.extensions.null-ls.code-actions"),
			-- null_ls.builtins.completion.spell,
		},
		on_attach = function(client, bufnr)
			if client.server_capabilities.documentFormattingProvider then
				-- with formatting capability we format when saving
				vim.cmd([[
        augroup vec_lsp_formatting
          au! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
        augroup END
      ]])
			end
		end,
		root_dir = u.root_pattern(".null-ls-root", ".venv", "go.mod", "Makefile", ".git"),
	})
end

return M

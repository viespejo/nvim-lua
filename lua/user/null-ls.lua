local M = {
	"nvimtools/none-ls.nvim",
	dependencies = {
		{
			"nvimtools/none-ls-extras.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
}

function M.config()
	local null_ls = require("null-ls")

	local diagnostics = null_ls.builtins.diagnostics
	local u = require("null-ls.utils")

	null_ls.setup({
		debug = false,
		sources = {
			diagnostics.golangci_lint,
			require("none-ls.diagnostics.flake8").with({
				extra_args = { "--ignore=E501,E203" },
				filetypes = { "python" },
			}),
			diagnostics.stylelint,
			require("none-ls.diagnostics.eslint"),
			require("none-ls.code_actions.eslint"),
			require("typescript.extensions.null-ls.code-actions"),
			-- null_ls.builtins.completion.spell,
		},
		root_dir = u.root_pattern(".null-ls-root", ".venv", "go.mod", "Makefile", ".git"),
	})
end

return M

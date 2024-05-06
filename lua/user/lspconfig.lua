local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/neodev.nvim",
		},
		-- Visualize lsp progress
		{
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup()
			end,
		},
		-- typescript plugin to use with tsserver directly
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			opts = {},
		},
	},
}

-- local function lsp_highlight_document(client)
-- 	-- Set autocommands conditional on server_capabilities
-- 	if client.server_capabilities.documentHighlightProvider then
-- 		vim.cmd([[
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--       ]])
-- 	end
-- end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "<leader>s", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
	keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(bufnr, "n", "<leader>qq", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
	keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "v", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<cr>', opts)
	keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<cr>', opts)
	keymap(bufnr, "n", "<leader>ll", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)
	keymap(bufnr, "n", "<leader>hh", "<cmd>lua vim.lsp.buf.document_highlight()<cr>", opts)
	keymap(bufnr, "n", "<leader>H", "<cmd>lua vim.lsp.buf.clear_references()<cr>", opts)
	vim.cmd([[ command! FormatLSP execute 'lua vim.lsp.buf.format()' ]])
	keymap(bufnr, "n", "<leader>fl", ":FormatLSP<cr>", { noremap = true, desc = "Format using LSP" })
	keymap(bufnr, "v", "<leader>fl", ":FormatLSP<cr>", { noremap = true, desc = "Format using LSP" })
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)

	-- lsp_highlight_document(client)

	-- native lsp inlay hints (Neovim nightly v0.10.0-dev-....)
	-- if client.supports_method("textDocument/inlayHint") then
	-- 	vim.lsp.inlay_hint.enable(bufnr, true)
	-- end

	-- print(client.name .. vim.inspect(client.server_capabilities))
	-- if client.server_capabilities.documentFormattingProvider then
	-- 	-- those servers with formatting capability we format when saving
	-- 	vim.cmd([[
	--        augroup vec_lsp_formatting
	--          au! * <buffer>
	--          autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
	--        augroup END
	--      ]])
	-- end
end

function M.common_capabilities()
	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_ok then
		return cmp_nvim_lsp.default_capabilities()
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	return capabilities
end

function M.config()
	local lspconfig = require("lspconfig")
	local icons = require("user.icons")

	local servers = {
		"astro",
		"clangd",
		"cssmodules_ls",
		"cssls",
		"intelephense",
		"lua_ls",
		"pyright",
		-- "tailwindcss",
		"html",
		-- "tsserver",
		"typescript-tools",
		"bashls",
		"jsonls",
		"yamlls",
		"marksman",
		"gopls",
	}

	local default_diagnostic_config = {
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
			},
		},
		virtual_text = true,
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	require("lspconfig.ui.windows").default_options.border = "rounded"

	for _, server in pairs(servers) do
		local opts = {
			on_attach = M.on_attach,
			capabilities = M.common_capabilities(),
		}

		local require_ok, settings = pcall(require, "user.lspsettings." .. server)
		if require_ok then
			opts = vim.tbl_deep_extend("force", settings, opts)
		end

		if opts.custom_on_attach then
			opts.on_attach = opts.custom_on_attach(M.on_attach)
		end

		if opts.custom_capabilities then
			opts.capabilities = opts.custom_capabilities(opts.capabilities)
		end

		if opts.disable_diagnostics then
			opts.handlers = {
				["textDocument/publishDiagnostics"] = function() end,
			}
		end

		if server == "lua_ls" then
			require("neodev").setup({
				library = {
					plugins = false, -- installed opt or start plugins in packpath
					-- you can also specify the list of plugins to make available as a workspace library
					-- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
				},
			})
		end

		lspconfig[server].setup(opts)
	end
end

return M

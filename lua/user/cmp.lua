local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-emoji",
			event = "InsertEnter",
		},
		{ "onsails/lspkind-nvim" },
		{
			"hrsh7th/cmp-buffer",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-path",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-cmdline",
			event = "InsertEnter",
		},
		{
			"saadparwaiz1/cmp_luasnip",
			event = "InsertEnter",
		},
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-nvim-lua",
		},
		-- {
		-- 	"roobert/tailwindcss-colorizer-cmp.nvim",
		-- },
	},
	event = "InsertEnter",
}

function M.config()
	-- require("tailwindcss-colorizer-cmp").setup({
	-- 	color_square_width = 2,
	-- })

	local cmp = require("cmp")
	local ls = require("luasnip")
	-- local icons = require("user.icons")
	local types = require("cmp.types")
	local lspkind = require("lspkind")

	-- vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "Comment" })
	-- vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { link = "Error" })
	-- vim.api.nvim_set_hl(0, "CmpItemKind", { link = "Special" })
	-- vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "NonText" })
	vim.api.nvim_set_hl(0, "MyPmenuSel", { link = "Todo" })

	cmp.setup({
		snippet = {
			expand = function(args)
				ls.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		completion = {
			autocomplete = false, -- disable auto-completion
		},
		mapping = cmp.mapping.preset.insert({
			["<C-p>"] = cmp.mapping(
				cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
				{ "i", "c" }
			),
			["<C-n>"] = cmp.mapping(
				cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
				{ "i", "c" }
			),
			-- ["<C-h>"] = function()
			-- 	if cmp.visible_docs() then
			-- 		cmp.close_docs()
			-- 	else
			-- 		cmp.open_docs()
			-- 	end
			-- end,
			["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			-- ["<C-d>"] = function()
			-- 	if cmp.visible_docs() then
			-- 		cmp.close_docs()
			-- 	else
			-- 		cmp.open_docs()
			-- 	end
			-- end,
			-- -- tab and shift-tab to navigate through snippets once expanded
			-- ["<Tab>"] = cmp.mapping(function(fallback)
			-- 	if luasnip.expand_or_jumpable() then
			-- 		luasnip.expand_or_jump()
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, {
			-- 	"i",
			-- 	"s",
			-- }),
			-- ["<S-Tab>"] = cmp.mapping(function(fallback)
			-- 	if luasnip.jumpable(-1) then
			-- 		luasnip.jump(-1)
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, {
			-- 	"i",
			-- 	"s",
			-- }),
		}),
		formatting = {
			-- fields = { "abbr", "kind", "menu" },
			format = lspkind.cmp_format({
				-- maxwidth = 50,
				menu = {
					buffer = "[buf]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[nvim_lua]",
					path = "[path]",
					luasnip = "[snip]",
					emoji = "[emoji]",
					["vim-dadbod-completion"] = "[db]",
				},
			}),
		},
		-- view = {
		-- 	docs = {
		-- 		auto_open = false,
		-- 	},
		-- },
		sources = cmp.config.sources({
			{ name = "nvim_lsp", keyword_length = 3 },
			{ name = "luasnip" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "emoji" },
		}),
		window = {
			completion = {
				winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:MyPmenuSel,Search:None",
			},
		},
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "buffer" },
		}),
	})

	cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
		sources = cmp.config.sources({
			{ name = "vim-dadbod-completion" },
			{ name = "buffer" },
		}),
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

return M

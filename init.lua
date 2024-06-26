require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocmds")
-- plugins
spec("user.colorscheme")
spec("user.devicons")
spec("user.treesitter")
spec("user.comment")
spec("user.mason")
spec("user.schemastore")
spec("user.lspconfig")
-- spec("user.null-ls")
spec("user.conform")
spec("user.nvim-lint")
spec("user.fzf-lua")
spec("user.nvimtree")
spec("user.oil")
spec("user.lualine")
spec("user.cmp")
spec("user.luasnip")
spec("user.undotree")
spec("user.fugitive")
spec("user.gitsigns")
spec("user.aerial")
spec("user.emmet")
spec("user.autopairs")
-- extras
spec("user.extras.matchup")
spec("user.extras.rainbow")
spec("user.extras.copilot")
spec("user.extras.toggleterm")
spec("user.extras.rest")
spec("user.extras.dressing")
spec("user.extras.trouble")
spec("user.extras.vim-visual-multi")
spec("user.extras.dadbod")
spec("user.extras.surround")
spec("user.extras.dap")
spec("user.extras.twoslash")
spec("user.extras.chatgpt")
spec("user.extras.obsidian")
require("user.lazy")

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
spec("user.null-ls")
spec("user.fzf-lua")
spec("user.nvimtree")
spec("user.oil")
spec("user.lualine")
spec("user.cmp")
spec("user.undotree")
spec("user.fugitive")
spec("user.gitsigns")
-- extras
spec("user.extras.matchup")
spec("user.extras.rainbow")
spec("user.extras.copilot")
spec("user.extras.toggleterm")
require("user.lazy")

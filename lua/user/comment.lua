local M = {
  "numToStr/Comment.nvim",
  lazy = false,
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
  },
}

function M.config()
  vim.g.skip_ts_context_commentstring_module = true

  ---@diagnostic disable: missing-fields
  require("ts_context_commentstring").setup {
    enable_autocmd = false,
  }

  require("Comment").setup {
    ---Function to call before (un)comment
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  }

  local ft = require("Comment.ft")
  ft.mysql = { "--%s", "/*%s*/" }
end

return M

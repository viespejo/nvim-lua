local M = {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
}

M.execs = {
  "astro",
  "clangd",
  "cssmodules_ls",
  "cssls",
  "intelephense",
  "lua_ls",
  "pyright",
  "tailwindcss",
  "html",
  "ts_ls",
  "bashls",
  "jsonls",
  "yamlls",
  "marksman",
  -- "eslint",
}

M.tools = {
  "flake8",
  "black",
}

function M.check()
  local mr = require("mason-registry")
  for _, tool in ipairs(M.tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

function M.config()
  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })
  M.check()

  require("mason-lspconfig").setup({
    ensure_installed = M.execs,
  })
end

return M

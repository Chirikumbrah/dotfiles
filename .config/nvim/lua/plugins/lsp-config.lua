return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "hadolint",
        "helm-ls",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "marksman",
        "prettier",
        "ruff",
        "ruff-lsp",
        "shfmt",
        "shellcheck",
        "sql-formatter",
        "sqlls",
        "stylua",
        "taplo",
        "tflint",
        "typescript-language-server",
        "xmlformatter",
        "yaml-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        jsonls = {},
        lua_ls = {},
        marksman = {},
        pyright = {},
        ruff_lsp = {},
        sqlls = {},
        taplo = {},
        tflint = {},
        tsserver = {},
        yamlls = {},
      },
    },
  },
}

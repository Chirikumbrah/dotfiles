return {
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

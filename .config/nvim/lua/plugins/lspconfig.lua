---@class PluginLspOpts
---@diagnostic disable-next-line: undefined-doc-name
---@type lspconfig.options

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        -- pyright = {},
        bashls = {},
        -- gopls = {},
        bicep = {},
        yamlls = {},
        marksman = {},
        powershell_es = {},
        terraformls = {},
        helm_ls = {},
      },
    },
  },
}

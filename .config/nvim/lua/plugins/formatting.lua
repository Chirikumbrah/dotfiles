-- if true then
--   return {}
-- end
--
return {
  "stevearc/conform.nvim",
  opts = function()
    ---@class ConformOpts
    local opts = {
      formatters_by_ft = {
        -- lua = { "stylua" },
        -- yaml = { "prettier" },
        markdown = { "prettier" },
        -- html = { "prettier" },
        -- css = { "prettier" },
        -- json = { "prettier" },
        -- javascript = { "prettier" },
        -- javascriptreact = { "prettier" },
        -- typescript = { "prettier" },
        -- typescriptreact = { "prettier" },
        -- xml = { "xmlformat" },
        -- python = { "ruff_format" },
        -- toml = { "taplo" },
        sh = { "shfmt" },
        -- fish = { "fish_indent" },
      },
      -- The options you set here will be merged with the builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
      -- formatters = {
      --   shfmt = {
      --     prepend_args = { "-i", "4", "-ci" },
      --   },
      -- },
    }
    return opts
  end,
}

return {
  "stevearc/conform.nvim",
  opts = function()
    ---@class ConformOpts
    local opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
        sh = { "shfmt" },
        toml = { "taplo" },
      },
    }
    return opts
  end,
}

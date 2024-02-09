return {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "fish",
        "vimdoc",
        "html",
        "json",
        "lua",
        -- "#bd93f9",
        -- "markdown",
        -- "markdown_inline",
        "python",
        "query",
        "regex",
        "vim",
        "yaml",
        "go",
        "terraform",
      },
      -- Disable terraform treesitter on fixture files
      highlight = {
        disable = function(lang)
          local buf_name = vim.fn.expand("%")
          if lang == "terraform" and string.find(buf_name, "fixture") then
            return true
          end
        end,
      },
    },
  },
}

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup({
            auto_install = true,
            ensure_installed = {
                "bash",
                "lua",
                "vim",
                "vimdoc",
                "terraform",
                "sql",
                "hcl",
                "python",
                "dockerfile",
                "xml",
                "json",
                "yaml",
                "toml",
                "javascript",
                "typescript",
            },
            indent = { enabled = true },
            highlight = { enabled = true },
        })
    end
}


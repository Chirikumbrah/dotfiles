return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "bash",
                "c",
                "dockerfile",
                "helm",
                "html",
                "javascript",
                "json",
                "lua",
                "python",
                "nginx",
                "query",
                "regex",
                "tmux",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end
            },
            indent = {
                enable = true,
                disable = {
                    "yaml",
                }
            },
            additional_vim_regex_highlighting = false,
        })
    end
}

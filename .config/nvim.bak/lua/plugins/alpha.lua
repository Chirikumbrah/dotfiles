return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                     ]],
            [[       ████ ██████           █████      ██                     ]],
            [[      ███████████             █████                             ]],
            [[      █████████ ███████████████████ ███   ███████████   ]],
            [[     █████████  ███    █████████████ █████ ██████████████   ]],
            [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
            [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
            [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
        }

        dashboard.section.buttons.val = {
            dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
            dashboard.button("n", "   New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("r", "   Recent files", ":Telescope oldfiles<CR>"),
            dashboard.button("g", "   Find text", ":Telescope live_grep<CR>"),
            dashboard.button("c", "   Config", function()
                require("telescope.builtin").find_files({ cwd = "$HOME/.config/nvim" })
            end),
            dashboard.button("l", "󰒲   Lazy", ":Lazy<CR>"),
            dashboard.button("q", "󰗼   Quit", ":qa<CR>"),
        }

        -- local footer = function()
        --     local stats = require("lazy").stats()
        --     local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        --     return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        -- end
        -- dashboard.section.footer.val = footer

        require("alpha").setup(dashboard.opts)
    end,
}

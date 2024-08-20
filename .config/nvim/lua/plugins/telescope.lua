return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            -- Local variables
            local builtin = require("telescope.builtin")
            local telescope = require("telescope")
            local config = require("telescope.config")

            if not unpack then
                unpack = table.unpack
            end
            local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

            local is_inside_work_tree = {}

            local project_files = function()
                local opts = {} -- define here if you want to define something

                local cwd = vim.fn.getcwd()
                if is_inside_work_tree[cwd] == nil then
                    vim.fn.system("git rev-parse --is-inside-work-tree")
                    is_inside_work_tree[cwd] = vim.v.shell_error == 0
                end

                if is_inside_work_tree[cwd] then
                    builtin.git_files(opts)
                else
                    builtin.find_files(opts)
                end
            end

            table.insert(vimgrep_arguments, "--hidden")
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")

            -- Pickers Configuration
            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                        }),
                    },
                },
                defaults = {
                    vimgrep_arguments = vimgrep_arguments,
                },
                pickers = {
                    find_files = {
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
                },
            })
            telescope.load_extension("ui-select")

            -- Keymaps
            -- vim.keymap.set("n", "<leader><space>", builtin.find_files, {})
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fp", project_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
        end,
    },
}

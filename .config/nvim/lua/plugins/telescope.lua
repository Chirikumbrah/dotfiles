return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        -- Local variables
        local builtin = require('telescope.builtin')
        local telescope = require("telescope")
        local config = require("telescope.config")

        local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

        -- Falling back to find_files if git_files can't find a .git directory --
        -- We cache the results of "git rev-parse"
        -- Process creation is expensive in Windows, so this reduces latency
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


        -- File and text search in hidden files and directories --
        -- I want to search in hidden/dot files.
        table.insert(vimgrep_arguments, "--hidden")
        -- I don't want to search in the `.git` directory.
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        -- Pickers Configuration
        telescope.setup({
            defaults = {
                -- `hidden = true` is not supported in text grep commands.
                vimgrep_arguments = vimgrep_arguments,
            },
            pickers = {
                find_files = {
                    -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },				
                },
            },
        })

        -- Keymaps
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fp', project_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
    end
}

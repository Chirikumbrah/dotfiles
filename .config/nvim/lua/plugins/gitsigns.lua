return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    cmd = "Gitsigns",
    keys = {
        { "]h", function() require("gitsigns").next_hunk() end, desc = "Go to next git hunk [gitsigns]" },
        { "[h", function() require("gitsigns").prev_hunk() end, desc = "Go to previous git hunk [gitsigns]" },
        { "<leader>h", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk [gitsigns]", mode = { "n", "v" } },
        { "<leader>l", function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle current line blame [gitsigns]" },
    },
    opts = {},
}

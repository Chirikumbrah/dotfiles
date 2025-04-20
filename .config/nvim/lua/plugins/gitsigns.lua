return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    cmd = "Gitsigns",
    keys = {
        { "<leader>gn", function() require("gitsigns").next_hunk() end, desc = "Go to next git hunk [gitsigns]" },
        { "<leader>gp", function() require("gitsigns").prev_hunk() end, desc = "Go to previous git hunk [gitsigns]" },
        { "<leader>gs", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk [gitsigns]", mode = { "n", "v" } },
        { "<leader>gl", function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle current line blame [gitsigns]" },
    },
    opts = {},
}

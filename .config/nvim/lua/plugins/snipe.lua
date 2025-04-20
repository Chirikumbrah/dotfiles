return {
    "leath-dub/snipe.nvim",
    keys = {
        {"gb", function () require("snipe").open_buffer_menu() end, desc = "Open buffer menu [snipe]"}
    },
    opts = {}
}

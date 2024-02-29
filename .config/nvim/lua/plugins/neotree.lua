return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    event_handlers = {

      {
        event = "file_opened",
        handler = function(file_path)
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
    window = {
      mappings = {
        ["l"] = "open",
      },
    },
  },
}

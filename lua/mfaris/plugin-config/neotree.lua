require("neo-tree").setup({
  filesystem = {
    hijack_netrw = "open_default",
    window = {
      width = 30,
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["v"] = 'open_vsplit'
      }
    }
  }
})

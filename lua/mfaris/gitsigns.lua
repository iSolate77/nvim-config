return {
  -- Git
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local status_ok, gitsigns = pcall(require, "gitsigns")
      if not status_ok then
        return
      end

      gitsigns.setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "契" },
          topdelete = { text = "契" },
          changedelete = { text = "▎" },
        },
        numhl = true,
        linehl = false,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 500,
        },
      })
    end,
  },
}

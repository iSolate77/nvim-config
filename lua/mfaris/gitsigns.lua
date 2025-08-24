return {
  -- Git
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

      -- navigation
      vim.keymap.set("n", "<leader>gn", function() gitsigns.next_hunk() end, { desc = "next hunk" })
      vim.keymap.set("n", "<leader>gN", function() gitsigns.prev_hunk() end, { desc = "prev hunk" })

      -- Stage / reset current hunk
      vim.keymap.set("n", "<leader>gs", function() gitsigns.stage_hunk() end, { desc = "stage hunk" })
      vim.keymap.set("n", "<leader>gr", function() gitsigns.reset_hunk() end, { desc = "reset hunk" })

      -- Stage / reset selection
      vim.keymap.set("v", "<leader>gs", function()
        local start = vim.fn.line("v")
        local finish = vim.fn.line(".")
        gitsigns.stage_hunk({ math.min(start, finish), math.max(start, finish) })
      end, { desc = "stage selection" })

      vim.keymap.set("v", "<leader>gr", function()
        local start = vim.fn.line("v")
        local finish = vim.fn.line(".")
        gitsigns.reset_hunk({ math.min(start, finish), math.max(start, finish) })
      end, { desc = "reset selection" })

      -- Buffer-wide ops
      vim.keymap.set("n", "<leader>gS", function() gitsigns.stage_buffer() end, { desc = "stage buffer" })
      vim.keymap.set("n", "<leader>gU", function() gitsigns.undo_stage_hunk() end, { desc = "undo stage hunk" })
      vim.keymap.set("n", "<leader>gR", function() gitsigns.reset_buffer() end, { desc = "reset buffer" })

      -- Preview / blame
      vim.keymap.set("n", "<leader>gp", function() gitsigns.preview_hunk() end, { desc = "preview hunk" })

      -- Diffs
      vim.keymap.set("n", "<leader>gd", function() gitsigns.diffthis() end, { desc = "diff against index" })
      vim.keymap.set("n", "<leader>gD", function() gitsigns.diffthis("~") end, { desc = "diff against last commit" })

      -- Toggles
      vim.keymap.set("n", "<leader>gt", function() gitsigns.toggle_deleted() end, { desc = "toggle show deleted" })
      vim.keymap.set("n", "<leader>gw", function() gitsigns.toggle_word_diff() end, { desc = "toggle word diff" })

      -- Lists
      vim.keymap.set("n", "<leader>gq", function()
        gitsigns.setqflist("all"); vim.cmd.copen()
      end, { desc = "qflist hunks" })

      vim.keymap.set("n", "<leader>gl", function()
        gitsigns.setloclist(0); vim.cmd.lopen()
      end, { desc = "loclist hunks" })

      -- Text object: inner hunk
      vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "inner hunk", silent = true })
    end,
  },
}

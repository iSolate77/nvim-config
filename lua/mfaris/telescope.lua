return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-hop.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      {
        "ThePrimeagen/git-worktree.nvim",
        config = function()
          require("git-worktree").setup({})
        end,
      },
      {
        "AckslD/nvim-neoclip.lua",
        config = function()
          require("neoclip").setup()
        end,
      },
    },
    priority = 100,
    config = function()
      require("mfaris.plugin-config.telescope")
    end,
  },
}

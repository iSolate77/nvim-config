return {
  -- DAP
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("mfaris.plugin-config.dap")
    end,
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
      "jayp0521/mason-nvim-dap.nvim",
      "leoluz/nvim-dap-go",
    },
  },
}

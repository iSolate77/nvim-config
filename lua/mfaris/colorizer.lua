return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup()
  end,
  {
    "norcalli/nvim-terminal.lua",
    config = function()
      require("terminal").setup()
    end,
  },
}

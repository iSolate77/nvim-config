return {
  --[[ { "hrsh7th/nvim-cmp", event = "InsertEnter" }, ]]
  --[[ { "hrsh7th/cmp-buffer" }, ]]
  --[[ { "hrsh7th/cmp-path" }, ]]
  --[[ { "hrsh7th/cmp-nvim-lua" }, ]]
  --[[ { "hrsh7th/cmp-nvim-lsp" }, ]]
  --[[ { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } }, ]]
  { "tamago324/cmp-zsh" },

  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup()
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "onsails/lspkind-nvim" },
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          "L3MON4D3/LuaSnip",
          version = "v2.*",
          build = "make install_jsregexp"
        }
      },
      { "tamago324/cmp-zsh" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { 'rafamadriz/friendly-snippets' },

    },
    config = function()
      require("mfaris.lsp.cmp")
    end,
  },
}

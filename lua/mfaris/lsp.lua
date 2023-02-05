return {
  {
    {
      "VonHeikemen/lsp-zero.nvim",
      dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" }, -- Required
        { "williamboman/mason.nvim" }, -- Optional
        { "williamboman/mason-lspconfig.nvim" }, -- Optional

        -- Autocompletion
        { "hrsh7th/nvim-cmp" }, -- Required
        { "hrsh7th/cmp-nvim-lsp" }, -- Required
        { "hrsh7th/cmp-buffer" }, -- Optional
        { "hrsh7th/cmp-path" }, -- Optional
        { "saadparwaiz1/cmp_luasnip" }, -- Optional
        { "hrsh7th/cmp-nvim-lua" }, -- Optional

        -- Snippets
        { "L3MON4D3/LuaSnip" }, -- Required
        { "rafamadriz/friendly-snippets" }, -- Optional
      },
      config = function()
        require("mfaris.lsp.lspzero")
      end,
    },
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "simrat39/inlay-hints.nvim",
    "j-hui/fidget.nvim",
    "folke/neodev.nvim",
    {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("null-ls").setup({
          debug = false,
          sources = {
            require("null-ls").builtins.formatting.prettierd.with({
              extra_filetypes = { "toml" },
              extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            }),
            require("null-ls").builtins.formatting.black.with({ extra_args = { "--fast" } }),
            require("null-ls").builtins.formatting.stylua,
            require("null-ls").builtins.formatting.google_java_format,
            require("null-ls").builtins.diagnostics.flake8,
            require("null-ls").builtins.diagnostics.misspell,
            require("null-ls").builtins.diagnostics.write_good,
          },
        })
      end,
    },
    "jose-elias-alvarez/nvim-lsp-ts-utils",
  },
}

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install plugins here

return packer.startup(function(use)
  -- My plugins here
  use("wbthomason/packer.nvim") -- packer itself
  use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  -- Telescope
  use("nvim-telescope/telescope.nvim")

  -- Treesitter
  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

  -- Git
  use("lewis6991/gitsigns.nvim")

  -- Copilot
  use({
    "zbirenbaum/copilot.lua",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  })
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  }

  -- LSP
  use({
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
  })

  -- Colorscheme
  use("folke/tokyonight.nvim")
  use("lunarvim/darkplus.nvim")
  use("navarasu/onedark.nvim")
  use("norcalli/nvim-colorizer.lua")

  -- Misc
  use("numToStr/Comment.nvim")
  use 'nvim-treesitter/nvim-treesitter-context'
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("kyazdani42/nvim-web-devicons")
  use("akinsho/bufferline.nvim")
  use("moll/vim-bbye")
  use("nvim-lualine/lualine.nvim")
  -- use("akinsho/toggleterm.nvim")
  use("ahmedkhalf/project.nvim")
  use("lewis6991/impatient.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("goolord/alpha-nvim")
  -- use("ggandor/leap.nvim")
  use("tpope/vim-repeat")
  use("iamcco/markdown-preview.nvim")

  -- QoL
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  })
  use("onsails/lspkind.nvim")
  use("RRethy/vim-illuminate")
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use("hrsh7th/cmp-nvim-lsp-signature-help")
  use("simrat39/rust-tools.nvim")
  use({
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup()
    end,
  })
  use("mbbill/undotree")

  -- DAP
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("theHamsta/nvim-dap-virtual-text")
  use("nvim-telescope/telescope-dap.nvim")
  use("jayp0521/mason-nvim-dap.nvim")

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

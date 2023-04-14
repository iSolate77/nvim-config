return {
	"nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
	-- LSP
	"rafamadriz/friendly-snippets",

	-- Colorscheme
	{ "catppuccin/nvim", name = "catppuccin" },
	"folke/tokyonight.nvim",
	"lunarvim/darkplus.nvim",

	-- Misc
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
	{ "kyazdani42/nvim-web-devicons", lazy = true },
	{
		"akinsho/bufferline.nvim",
		event = "BufWinEnter",
		config = function()
			require("mfaris.plugin-config.bufferline")
		end,
	},
	"moll/vim-bbye",
	-- use("akinsho/toggleterm.nvim")
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("mfaris.plugin-config.project")
		end,
	},
	{
		"lewis6991/impatient.nvim",
		config = function()
			require("mfaris.plugin-config.impatient")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("mfaris.plugin-config.indentline")
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("mfaris.plugin-config.alpha")
		end,
	},
	-- use("ggandor/leap.nvim")
	"tpope/vim-repeat",

	-- QoL
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("mfaris.plugin-config.illuminate")
		end,
	},
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"simrat39/rust-tools.nvim",
	{
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
		end,
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "undotree" },
		},
	},
	{
		"andweeb/presence.nvim",
		config = function()
			require("mfaris.plugin-config.presence")
		end,
	},
}

return {
	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	{
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
		end,
	},

	-- Copilot
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					erase_after_cursor = true,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 16.x
				server_opts_overrides = {},
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup({
				clear_after_cursor = true,
			})
		end,
	},

	{
		"RRethy/vim-illuminate",
		config = function()
			vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }
			vim.api.nvim_set_keymap(
				"n",
				"<a-n>",
				'<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
				{ noremap = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<a-p>",
				'<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
				{ noremap = true }
			)
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
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup()
		end,
	},

	"tpope/vim-repeat",
	-- "moll/vim-bbye",
	{
		"simrat39/inlay-hints.nvim",
		config = function()
			require("inlay-hints").setup()
		end,
	},

	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({})
		end,
	},
	{
		"jinh0/eyeliner.nvim",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
				dim = false,
			})
		end,
	},
}

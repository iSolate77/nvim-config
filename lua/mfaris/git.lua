return {
	-- Git
	"tpope/vim-fugitive",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("mfaris.plugin-config.gitsigns")
		end,
	},
}

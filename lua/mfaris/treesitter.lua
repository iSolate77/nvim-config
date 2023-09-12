return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			require("mfaris.plugin-config.treesitter")
			require("mfaris.plugin-config.treesitter-context")
		end,
		build = ":TSUpdate",
	},
}

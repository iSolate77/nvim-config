function ColorMyPencils(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	-- "folke/tokyonight.nvim",
	-- catpuccin
	"catppuccin/nvim",
	-- lazy = false,
	-- priority = 1000,
	config = function()
		-- require("tokyonight").setup({
		require("catppuccin").setup({
			flavour = "mocha",
			-- 	-- your configuration comes here
			-- 	-- or leave it empty to use the default settings
			-- 	style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
			-- 	transparent = true, -- Enable this to disable setting the background color
			-- 	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
			-- 	styles = {
			-- 		-- Style to be applied to different syntax groups
			-- 		-- Value is any valid attr-list value for `:help nvim_set_hl`
			-- 		comments = { italic = true },
			-- 		keywords = { italic = false },
			-- 		-- Background styles. Can be "dark", "transparent" or "normal"
			-- 		-- sidebars = "dark", -- style for sidebars, see below
			-- 		-- floats = "dark", -- style for floating windows
			-- 	},
			-- 	-- disable_background = true,

			vim.cmd("colorscheme catppuccin"),

			ColorMyPencils(),
		})

		-- vim.cmd([[colorscheme tokyonight-storm]])
	end,
}

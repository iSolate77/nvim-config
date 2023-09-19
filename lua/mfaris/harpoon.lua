return {
	"ThePrimeagen/harpoon",
	-- TODO
	-- config
	config = function()
		require("harpoon").setup()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<leader>p", ui.toggle_quick_menu)

		-- Keybindings for navigation between marked files
		local navKeys = { "h", "j", "k", "l" }
		for idx, key in ipairs(navKeys) do
			vim.keymap.set("n", "<leader><leader>" .. key, function()
				ui.nav_file(idx)
			end, { noremap = true, silent = true })
		end
	end,
}

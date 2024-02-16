return {
	"ThePrimeagen/harpoon",
	-- TODO
	-- config
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():append()
		end)
		vim.keymap.set("n", "<leader>p", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		-- Keybindings for navigation between marked files
		local navKeys = { "h", "j", "k", "l" }
		for idx, key in ipairs(navKeys) do
			vim.keymap.set("n", "<leader><leader>" .. key, function()
				harpoon:list():select(idx)
			end, { noremap = true, silent = true })
		end

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-N>", function()
			harpoon:list():next()
		end)
	end,
}

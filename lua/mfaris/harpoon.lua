return {
	"ThePrimeagen/harpoon",
	-- TODO
	-- config
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		-- Keybindings for navigation between marked files
		vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-N>", function()
			harpoon:list():next()
		end)
	end,
}

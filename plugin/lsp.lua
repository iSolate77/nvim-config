vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
	{ desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
	{ desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>k", function() vim.diagnostic.open_float() end,
	{ desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover Documentation" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
-- gD handled by mini.pick (type definition)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "format" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })
vim.keymap.set("n", "<leader>lt", "<cmd>lua vim.diagnostic.config({ virtual_text = true })<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>lua vim.diagnostic.config({ virtual_text = false })<CR>")
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "[W]orkspace [A]dd Folder" })
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "[W]orkspace [R]emove Folder" })
vim.keymap.set("n", "<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "[W]orkspace [L]ist Folders" })


vim.lsp.config('*', {
	root_markers = { '.git' },
	capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = {
		focusable = true,
		style = "minimal",
		source = 'if_many',
		header = "",
		prefix = "",
	},
})

vim.lsp.enable({
	'luals',
	'gopls',
	'clangd',
	'tinymist',
	'zls',
	'dts_lsp',
	'ts_ls',
	'buf_ls',
	'ols',
})

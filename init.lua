require("mfaris.lsp.lspconfig")
require("mfaris.plugins")
require("mfaris.keymaps")
require("mfaris.options")
require("mfaris.colourscheme")
require("mfaris.plugin-config")

require('lspkind').init({
	symbol_map = {
		Copilot = " ",
	},
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

require("mason.settings").set({
	ui = {
		border = "rounded",
	},
})


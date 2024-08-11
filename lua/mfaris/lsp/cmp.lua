local lspkind = require("lspkind")
lspkind.init({
	symbol_map = {
		Copilot = "",
	},
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

local cmp = require("cmp")
-- lspkind.config()
local cmp_select = { behavior = cmp.SelectBehavior.Insert }
local ok1, luasnip = pcall(require, "luasnip")
if not ok1 then
	print("help me, I've crashed")
	return
end
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-space>"] = cmp.mapping.complete(),
		["<Tab>"] = nil,
		["<S-Tab>"] = nil,
		["<CR>"] = nil,
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "copilot" },
		{ name = "luasnip" },
		{ name = "buffer",                 keyword_length = 5 },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[API]",
				nvim_lsp_signature_help = "[LSP Signature]",
				buffer = "[Buf]",
				luasnip = "[Snip]",
				copilot = "[Copilot]",
				path = "[Path]",
			},
		}),
	},
})

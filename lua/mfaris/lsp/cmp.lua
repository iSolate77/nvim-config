local ok, lspkind = pcall(require, "lspkind")
if not ok then
	return
end

lspkind.config = function()
	require("lspkind").init({
		symbol_map = {
			Copilot = " ",
		},
	})

	vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end

local cmp = require("cmp")
lspkind.config()
local cmp_select = { behavior = cmp.SelectBehavior.Insert }
local luasnip = require("luasnip")
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
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behaviour = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
		["<M-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
			{ "i", "c" }
		),
		["<C-space>"] = cmp.mapping.complete(),
		["<Tab>"] = nil,
		["<S-Tab>"] = nil,
		["<CR>"] = nil,
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "copilot" },
		{ name = "path" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 5 },
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
				buffer = "[Buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[API]",
				luasnip = "[Snip]",
				copilot = "[Copilot]",
				path = "[Path]",
				nvim_lsp_signature_help = "[LSP Signature]",
			},
		}),
	},
})

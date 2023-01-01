local ok, lspkind = pcall(require, "lspkind")
if not ok then
	return
end

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.configure("sumneko_lua", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

lsp.ensure_installed({
	"sumneko_lua",
	"pyright",
	"yamlls",
	"bashls",
	"clangd",
	"rust_analyzer",
	"texlab",
	"taplo",
	"tsserver",
	"tailwindcss",
	"emmet_ls",
})

lsp.set_preferences({
	sign_icons = {
		error = "",
		warn = "",
		hint = "",
		info = "",
	},
	set_lsp_keymaps = false,
})


local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
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
	["<C-space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	sources = {
		{ name = "nvim_lua" },
		{ name = "copilot" },
		{ name = "path" },
		{ name = "nvim_lsp" },
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
	mapping = cmp_mappings,
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local keymap = vim.keymap.set
	keymap("n", "K", vim.lsp.buf.hover, { buffer = 0 }, opts)
	keymap("n", "gd", vim.lsp.buf.definition, { buffer = 0 }, opts)
	keymap("n", "gD", vim.lsp.buf.declaration, { buffer = 0 }, opts)
	keymap("n", "gi", vim.lsp.buf.implementation, { buffer = 0 }, opts)
	keymap("n", "gr", vim.lsp.buf.references, { buffer = 0 }, opts)
	keymap("n", "gr", require("telescope.builtin").lsp_references, { buffer = 0 }, opts)
	keymap("n", "<leader>lf", vim.lsp.buf.format, { buffer = 0 }, opts)
	keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap("n", "<leader>lI", "<cmd>Mason<cr>", opts)
	keymap("n", "<leader>la", vim.lsp.buf.code_action, { buffer = 0 }, opts)
	keymap("n", "<leader>lj", vim.diagnostic.goto_next, { buffer = 0 }, opts)
	keymap("n", "<leader>lk", vim.diagnostic.goto_prev, { buffer = 0 }, opts)
	keymap("n", "<leader>lr", vim.lsp.buf.rename, { buffer = 0 }, opts)
	keymap("n", "<leader>ls", vim.lsp.buf.signature_help, { buffer = 0 }, opts)
	keymap("n", "<leader>lq", vim.diagnostic.setloclist, { buffer = 0 }, opts)
	keymap("n", "<leader>lt", "<cmd>lua vim.diagnostic.config({ virtual_text = true })<CR>", opts)
	keymap("n", "<leader>tl", "<cmd>lua vim.diagnostic.config({ virtual_text = false })<CR>", opts)

	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end)

local rust_lsp = lsp.build_options("rust_analyzer", {
  settings = {
    ["rust-analyzer"] ={
      inlayHints = {locationLinks = false}
    }
  }
})

lsp.setup()

require("rust-tools").setup({ server = rust_lsp })
require('lspconfig').html.setup({
  filetypes = {'html', 'htmldjango'},
})


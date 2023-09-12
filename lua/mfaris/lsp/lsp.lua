require("neodev").setup({
	override = function(_, library)
		library.enabled = true
		library.plugins = true
	end,
	lspconfig = true,
	pathStrict = true,
})
require("fidget").setup()

local servers = {
	lua_ls = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.stdpath("config") .. "/lua"] = true,
			},
		},
	},

	clangd = {
		capabilities = {
			offsetEncoding = "utf-8",
		},
	},

	tailwindcss = {
		single_file_support = true,
		root_dir = require("lspconfig").util.root_pattern(
			"tailwind.config.js",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.ts",
			"package.json",
			"node_modules",
			".git"
		),
	},

	gopls = {},
	pyright = {},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				inlayHints = { locationLinks = false },
			},
		},
	},
	tsserver = {},
	html = {},
}

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

local on_attach = function(client, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("<leader>lf", vim.lsp.buf.format, "format")
	nmap("<leader>la", vim.lsp.buf.code_action, "[C]ode [A]ction")
	nmap("<leader>ld", require("telescope.builtin").diagnostics, "[D]iagnostics")
	nmap("<leader>lr", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ls", vim.lsp.buf.signature_help, "Signature Documentation")
	nmap("<leader>lt", "<cmd>lua vim.diagnostic.config({ virtual_text = true })<CR>")
	nmap("<leader>tl", "<cmd>lua vim.diagnostic.config({ virtual_text = false })<CR>")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- vim.diagnostic.set({
-- 	diagnostics = {
-- 		signs = {
-- 			error = "",
-- 			warn = "",
-- 			hint = "",
-- 			info = "",
-- 		},
-- 	},
-- })

vim.diagnostic.config({
	signs = {
		error = "",
		warn = "",
		hint = "",
		info = "",
	},
})
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- sign_icons = {
--   error = "",
--   warn = "",
--   hint = "",
--   info = "",
-- },
--

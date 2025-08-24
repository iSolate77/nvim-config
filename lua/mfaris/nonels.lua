return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			debug = false,
			sources = {
				null_ls.builtins.formatting.prettierd.with({
					extra_filetypes = { "toml", "tmpl" },
					extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
				}),
				null_ls.builtins.formatting.buf.with({
					filetypes = { "proto" },
				}),
				null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.google_java_format,
				null_ls.builtins.diagnostics.write_good,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								filter = function(client)
									return client.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,
		})
	end,
}

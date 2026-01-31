return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		local ok_prettierd, prettierd = pcall(require, "none-ls.formatting.prettierd")
		if not ok_prettierd then
			local f = null_ls.builtins.formatting
			if f then
				prettierd = f.prettierd
			end
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
				local has_any = false
				for _, c in ipairs(clients) do
					if c.supports_method("textDocument/formatting") then
						has_any = true
						break
					end
				end
				if not has_any then
					return
				end
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						local buf_ft = vim.bo[bufnr].filetype
						local has_null_ls = #require("null-ls.sources").get_available(buf_ft,
							require("null-ls").methods.FORMATTING) > 0
						vim.lsp.buf.format({
							bufnr = bufnr,
							filter = function(client)
								if has_null_ls then
									return client.name == "null-ls"
								end
								return client.name ~= "null-ls"
							end,
						})
					end,
				})
			end,
		})

		local sources = {
			null_ls.builtins.formatting.buf.with({
				filetypes = { "proto" },
			}),
			null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
			null_ls.builtins.diagnostics.write_good,
		}
		if prettierd then
			table.insert(sources, 1, prettierd.with({
				extra_filetypes = { "toml", "tmpl", "go.tmpl" },
				extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
			}))
		end

		null_ls.setup({
			debug = false,
			sources = sources,
			on_attach = function(_, _)
			end,
		})
	end,
}

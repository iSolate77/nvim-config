-- return {
-- 	"jose-elias-alvarez/null-ls.nvim",
-- 	config = function()
-- 		require("null-ls").setup({
-- 			debug = false,
-- 			sources = {
-- 				require("null-ls").builtins.formatting.prettierd.with({
-- 					extra_filetypes = { "toml" },
-- 					extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
-- 				}),
-- 				require("null-ls").builtins.formatting.black.with({ extra_args = { "--fast" } }),
-- 				require("null-ls").builtins.formatting.stylua,
-- 				require("null-ls").builtins.formatting.google_java_format,
-- 				require("null-ls").builtins.diagnostics.flake8,
-- 				require("null-ls").builtins.diagnostics.misspell,
-- 				require("null-ls").builtins.diagnostics.write_good,
-- 			},
-- 		})
-- 	end,
-- }

return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				tmpl = { "prettierd" },
				toml = {
					"prettierd",
					args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
				},
			},
			format_on_save = {
				timeout = 500,
				lsp_fallback = true,
			},
		})
	end,
}

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
		      nnoremap <silent> <buffer> q :close<CR>
		      set nobuflisted
		    ]])
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "man",
	command = "nnoremap <buffer> q :quit<CR>",
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 250 })
	end,
})

-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	callback = function()
-- 		vim.lsp.buf.format()
-- 	end,
-- })

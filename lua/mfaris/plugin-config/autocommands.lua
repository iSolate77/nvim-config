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

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.lsp.buf.format()
	end,
})

local treesitter_group = vim.api.nvim_create_augroup("mfaris_treesitter_start", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = treesitter_group,
	callback = function(args)
		if vim.b[args.buf].ts_highlight then
			return
		end

		local ft = vim.bo[args.buf].filetype
		if ft == "" then
			return
		end

		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end

		if not vim.treesitter.language.add(lang) then
			return
		end

		vim.treesitter.start(args.buf, lang)
	end,
})

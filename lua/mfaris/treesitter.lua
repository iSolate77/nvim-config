return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter").install({
				"c", "go", "gomod", "gosum", "gowork", "rust", "python", "html", "javascript", "typescript", "lua", "zig", "proto"
			})

			local treesitter_group = vim.api.nvim_create_augroup("mfaris_treesitter_start", { clear = true })

			local function start_treesitter(bufnr)
				if vim.b[bufnr].ts_highlight then
					return
				end

				local ft = vim.bo[bufnr].filetype
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

				vim.treesitter.start(bufnr, lang)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = treesitter_group,
				callback = function(args)
					start_treesitter(args.buf)
				end,
			})

			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(bufnr) then
					start_treesitter(bufnr)
				end
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("mfaris.plugin-config.treesitter")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("mfaris.plugin-config.treesitter-context")
		end,
	},
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require("lazy").setup('mfaris', {
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
    },
  },
})

require('mfaris.plugin-config.autocommands')
require('settings.keymaps')
require('settings.options')
-- require("mfaris.lsp.lspconfig")
-- require("mfaris.plugins")
-- require("mfaris.keymaps")
-- require("mfaris.options")
-- require("mfaris.colourscheme")
-- require("mfaris.plugin-config")

require("mason.settings").set({
	ui = {
		border = "rounded",
	},
})

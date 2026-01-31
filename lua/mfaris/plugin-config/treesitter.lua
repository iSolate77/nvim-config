-- Treesitter textobjects configuration for Neovim 0.11+
local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")

-- Selection keymaps
vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer") end)
vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner") end)
vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@conditional.outer") end)
vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@conditional.inner") end)
vim.keymap.set({ "x", "o" }, "aa", function() select.select_textobject("@parameter.outer") end)
vim.keymap.set({ "x", "o" }, "ia", function() select.select_textobject("@parameter.inner") end)

-- Move keymaps
vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer") end)
vim.keymap.set({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer") end)
vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer") end)
vim.keymap.set({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer") end)
vim.keymap.set({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer") end)
vim.keymap.set({ "n", "x", "o" }, "][", function() move.goto_next_end("@class.outer") end)
vim.keymap.set({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer") end)
vim.keymap.set({ "n", "x", "o" }, "[]", function() move.goto_previous_end("@class.outer") end)
vim.keymap.set({ "n", "x", "o" }, "]p", function() move.goto_next_start("@parameter.inner") end)
vim.keymap.set({ "n", "x", "o" }, "[p", function() move.goto_previous_start("@parameter.inner") end)

-- Swap keymaps
vim.keymap.set("n", "<M-Space><M-p>", function() swap.swap_next("@parameter.inner") end)
vim.keymap.set("n", "<M-BS><M-p>", function() swap.swap_previous("@parameter.inner") end)
vim.keymap.set("n", "<M-Space><M-f>", function() swap.swap_next("@function.outer") end)
vim.keymap.set("n", "<M-BS><M-f>", function() swap.swap_previous("@function.outer") end)

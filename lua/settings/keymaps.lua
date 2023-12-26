local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- -- Close buffers
-- keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Clear highlights
-- keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Do not yank with x
keymap("n", "x", '"_x')

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Moving around sanely
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
-- Move text
keymap("x", "<C-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<C-k>", ":move '<-2<CR>gv-gv", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

keymap("n", "<leader>e", ":Vex<CR>:vertical resize 25<CR>", opts)

-- Comment
-- keymap("n", "<leader>/", require("Comment.api").toggle.linewise.current, opts)
-- keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>')

-- Tmux NAV
keymap("n", "<C-h>", "<Cmd>NavigatorLeft<CR>", opts)
keymap("n", "<C-j>", "<Cmd>NavigatorDown<CR>", opts)
keymap("n", "<C-k>", "<Cmd>NavigatorUp<CR>", opts)
keymap("n", "<C-l>", "<Cmd>NavigatorRight<CR>", opts)

keymap("n", "<leader>b", "<Cmd>Telescope buffers<CR>", opts)

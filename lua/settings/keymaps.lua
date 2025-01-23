local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Better window navigation
keymap("n", "<C-h>", ":wincmd h<CR>", opts)
keymap("n", "<C-j>", ":wincmd j<CR>", opts)
keymap("n", "<C-k>", ":wincmd k<CR>", opts)
keymap("n", "<C-l>", ":wincmd l<CR>", opts)

keymap("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Tmux Navigator Left" })
keymap("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Tmux Navigator Down" })
keymap("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Tmux Navigator Up" })
keymap("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Tmux Navigator Right" })

-- Resize with arrows
keymap("n", "<M-Up>", ":resize -2<CR>", opts)
keymap("n", "<M-Down>", ":resize +2<CR>", opts)
keymap("n", "<M-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<M-Right>", ":vertical resize +2<CR>", opts)

-- greatest remap ever
keymap("x", "<leader>p", [["_dP]], opts)

-- next greatest remap ever : asbjornHaland
keymap({ "n", "v" }, "<leader>y", [["+y]], opts)
keymap("n", "<leader>Y", [["+Y]])

keymap({ "n", "v" }, "<leader>d", [["_d]], opts)

-- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- -- Close buffers
-- keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Do not yank with x
keymap("n", "x", '"_x')

-- Insert --
-- -- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)
-- keymap("i", "kj", "<ESC>", opts)

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
-- keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
-- keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
-- keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
-- keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- quick fix list
keymap("n", "<leader>cn", "<CMD>cnext<CR>", opts)
keymap("n", "<leader>cp", "<CMD>cprev<CR>", opts)

keymap("n", "<leader>e", "<CMD>Oil<CR>", opts)

-- Comment
-- keymap("n", "<leader>/", require("Comment.api").toggle.linewise.current, opts)
-- keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>')

keymap("n", "<leader>b", "<Cmd>Telescope buffers<CR>", opts)

keymap("n", "<leader><leader>c", ":e ~/.config/nvim/init.lua <CR>", opts)

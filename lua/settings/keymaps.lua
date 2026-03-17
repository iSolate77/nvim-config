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

-- Do not yank with x
keymap("n", "x", '"_x')

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Moving around sanely
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- quick fix list
keymap("n", "<leader>cn", "<CMD>cnext<CR>", opts)
keymap("n", "<leader>cp", "<CMD>cprev<CR>", opts)

-- In quickfix/location list windows:
-- <CR> jumps and closes the list, <S-CR> jumps and keeps it open.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(args)
    local qf_opts = { buffer = args.buf, silent = true, nowait = true }

    local function jump(close_list)
      local info = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
      local is_loclist = info and info.loclist == 1

      if is_loclist then
        vim.cmd("ll")
        if close_list then
          vim.cmd("lclose")
        end
      else
        vim.cmd("cc")
        if close_list then
          vim.cmd("cclose")
        end
      end
    end

    vim.keymap.set("n", "<CR>", function()
      jump(true)
    end, qf_opts)

    vim.keymap.set("n", "<S-CR>", function()
      jump(false)
    end, qf_opts)
  end,
})

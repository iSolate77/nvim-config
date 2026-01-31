return {
  {
    "nvim-mini/mini.ai",
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    'nvim-mini/mini.comment',
    config = function()
      require("mini.comment").setup()
    end
  },
  {
    'nvim-mini/mini.surround',
    config = function()
      require("mini.surround").setup()
    end
  },
  {
    'nvim-mini/mini.move',
    config = function()
      require("mini.move").setup(
        {
          mappings = {
            left = '<M-h>',
            right = '<M-l>',
            down = '<M-j>',
            up = '<M-k>',
          },
        })
    end
  },
  --   {
  --     'nvim-mini/mini.pick',
  --     dependencies = {
  --       { 'nvim-mini/mini.extra' },
  --       { 'nvim-mini/mini.icons', opts = {} },
  --     },
  --     config = function()
  --       local pick = require('mini.pick')
  --       pick.setup()
  --       require('mini.extra').setup()
  --
  --       local extra = require('mini.extra')
  --
  --       local function is_git_repo()
  --         if vim.fn.executable('git') ~= 1 then return false end
  --         vim.fn.system({ 'git', 'rev-parse', '--is-inside-work-tree' })
  --         return vim.v.shell_error == 0
  --       end
  --
  --       local function smart_files()
  --         if is_git_repo() then
  --           pick.builtin.files({ tool = 'git' })
  --         else
  --           pick.builtin.files()
  --         end
  --       end
  --
  --       local map = function(mode, lhs, rhs, desc)
  --         vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
  --       end
  --
  --       -- Find
  --       map('n', '<leader>fs', smart_files, 'Smart Find Files')
  --       map('n', '<leader>fb', function() pick.builtin.buffers() end, 'Buffers')
  --       map('n', '<leader>fc', function() pick.builtin.files({}, { source = { cwd = vim.fn.stdpath('config') } }) end,
  --         'Find Config File')
  --       map('n', '<leader>ff', function() pick.builtin.files() end, 'Find Files')
  --       map('n', '<leader>fg', function() pick.builtin.files({ tool = 'git' }) end, 'Find Git Files')
  --       map('n', '<leader>fp', function() extra.pickers.git_files() end, 'Git Files')
  --       map('n', '<leader>fr', function() extra.pickers.oldfiles() end, 'Recent')
  --
  --       -- Grep
  --       map('n', '<leader>sb', function() extra.pickers.buf_lines({ scope = 'current' }) end, 'Buffer Lines')
  --       map('n', '<leader>sB', function() extra.pickers.buf_lines({ scope = 'all' }) end, 'Grep Open Buffers')
  --       map('n', '<leader>sg', function() pick.builtin.grep_live() end, 'Live Grep')
  --
  --       -- Search
  --       map('n', '<leader>s"', function() extra.pickers.registers() end, 'Registers')
  --       map('n', '<leader>s/', function() extra.pickers.history({ scope = '/' }) end, 'Search History')
  --       map('n', '<leader>sc', function() extra.pickers.history({ scope = ':' }) end, 'Command History')
  --       map('n', '<leader>sC', function() extra.pickers.commands() end, 'Commands')
  --       map('n', '<leader>sd', function() extra.pickers.diagnostic() end, 'Diagnostics')
  --       map('n', '<leader>sh', function() pick.builtin.help() end, 'Help Pages')
  --       map('n', '<leader>sH', function() extra.pickers.hl_groups() end, 'Highlights')
  --       map('n', '<leader>sj', function() extra.pickers.list({ scope = 'jump' }) end, 'Jumps')
  --       map('n', '<leader>sk', function() extra.pickers.keymaps() end, 'Keymaps')
  --       map('n', '<leader>sl', function() extra.pickers.list({ scope = 'location' }) end, 'Location List')
  --       map('n', '<leader>sm', function() extra.pickers.marks() end, 'Marks')
  --       map('n', '<leader>sq', function() extra.pickers.list({ scope = 'quickfix' }) end, 'Quickfix List')
  --
  --       -- LSP
  --       map('n', 'gr', function() extra.pickers.lsp({ scope = 'references' }) end, 'References')
  --       map('n', 'gi', function() extra.pickers.lsp({ scope = 'implementation' }) end, 'Goto Implementation')
  --       map('n', 'gD', function() extra.pickers.lsp({ scope = 'type_definition' }) end, 'Goto Type Definition')
  --       map('n', '<leader>ss', function() extra.pickers.lsp({ scope = 'document_symbol' }) end, 'LSP Symbols')
  --       map('n', '<leader>sS', function() extra.pickers.lsp({ scope = 'workspace_symbol' }) end, 'LSP Workspace Symbols')
  --     end
  --   },
  --   {
  --     'nvim-mini/mini.notify',
  --     config = function()
  --       local n = require('mini.notify')
  --       n.setup()
  --       vim.notify = n.make_notify()
  --       vim.keymap.set('n', '<leader>n', function() MiniNotify.show_history() end,
  --         { desc = 'Notification History', silent = true })
  --       vim.keymap.set('n', '<leader>nh', function() MiniNotify.clear() end,
  --         { desc = 'Dismiss All Notifications', silent = true })
  --     end
  --   },
}

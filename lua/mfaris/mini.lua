return {
  {
    "echasnovski/mini.ai",
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    'echasnovski/mini.comment',
    config = function()
      require("mini.comment").setup()
    end
  },
  {
    'echasnovski/mini.surround',
    config = function()
      require("mini.surround").setup()
    end
  },
  {
    'echasnovski/mini.move',
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
  -- {
  --   'echasnovski/mini.files',
  --   keys = {
  --     {
  --       "<leader>e",
  --       function()
  --         local mini_files = require("mini.files")
  --         if not mini_files.close() then mini_files.open(vim.api.nvim_buf_get_name(0), true) end
  --       end,
  --       desc = "Open mini.files current working file",
  --     },
  --   },
  --   config = function()
  --     require("mini.files").setup({
  --       mappings = {
  --         go_in = 'L',
  --         go_in_plus = 'l',
  --       },
  --     })
  --   end
  -- },
}

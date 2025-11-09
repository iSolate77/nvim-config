return {
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },
    -- {
    --     "almahoozi/repl.nvim",
    --     config = function()
    --         require("repl").setup({
    --             Mappings = {
    --                 Run = "<leader><cr>",
    --             },
    --         })
    --     end,
    -- },
    -- Git related plugins
    -- "tpope/vim-fugitive",
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim", -- optional, but recommended
        },
        config = function()
            require("neogit").setup({
                integrations = { diffview = true },
                use_default_keymaps = true,
                auto_refresh = true,
            })
        end,
    },

    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",

    -- "github/copilot.vim",
    -- Copilot
    -- {
    --     "zbirenbaum/copilot.lua",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup({
    --             panel = {
    --                 enabled = true,
    --                 auto_refresh = false,
    --                 erase_after_cursor = true,
    --                 keymap = {
    --                     jump_prev = "[[",
    --                     jump_next = "]]",
    --                     accept = "<CR>",
    --                     refresh = "gr",
    --                     open = "<M-CR>",
    --                 },
    --             },
    --             suggestion = {
    --                 enabled = true,
    --                 auto_trigger = false,
    --                 debounce = 75,
    --                 keymap = {
    --                     accept = "<M-l>",
    --                     accept_word = false,
    --                     accept_line = false,
    --                     next = "<M-]>",
    --                     prev = "<M-[>",
    --                     dismiss = "<C-]>",
    --                 },
    --             },
    --             filetypes = {
    --                 help = false,
    --                 gitcommit = false,
    --                 gitrebase = false,
    --                 hgcommit = false,
    --                 svn = false,
    --                 cvs = false,
    --                 ["."] = false,
    --             },
    --             copilot_node_command = "node",
    --             server_opts_overrides = {},
    --         })
    --     end,
    -- },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     config = function()
    --         require("copilot_cmp").setup({
    --             suggestion = { enabled = false },
    --             panel = { enabled = false },
    --         })
    --     end,
    -- },

    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "undotree" },
        },
    },
    -- {
    --     "andweeb/presence.nvim",
    --     config = function()
    --         require("mfaris.plugin-config.presence")
    --     end,
    -- },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup()
        end,
    },

    "tpope/vim-repeat",
    -- "moll/vim-bbye",
    -- {
    --     "simrat39/inlay-hints.nvim",
    --     config = function()
    --         require("inlay-hints").setup()
    --     end,
    -- },
    --
    -- {
    --     "simrat39/rust-tools.nvim",
    -- },
    {
        "jinh0/eyeliner.nvim",
        config = function()
            require("eyeliner").setup({
                highlight_on_key = true,
                dim = false,
            })
        end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            modes = { char = { enabled = false }, },
        },
        -- stylua: ignore
        keys = {
            { "<leader>sf", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "<leader>sF", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",          mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",          mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-x>",      mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        }
    },
    {
        "stevearc/oil.nvim",
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        config = function()
            require("oil").setup({
                columns = { "icon", "permissions" },
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                },
            })
            vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { silent = true })
        end,
    },
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     main = "ibl",
    --     opts = {
    --
    --         scope = {
    --             enabled = true,
    --             show_start = false,
    --         },
    --     },
    -- },
    {
        'chomosuke/typst-preview.nvim',
        lazy = false, -- or ft = 'typst'
        version = '1.*',
        opts = {},    -- lazy.nvim will implicitly calls `setup {}`
    },
}

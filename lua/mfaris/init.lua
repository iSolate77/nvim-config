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
    -- "tpope/vim-rhubarb",

    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
    {
        "christoomey/vim-tmux-navigator",
    },

    -- "github/copilot.vim",
    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true,
                    auto_refresh = false,
                    erase_after_cursor = true,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>",
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = false,
                    debounce = 75,
                    keymap = {
                        accept = "<M-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = "node",
                server_opts_overrides = {},
            })
        end,
    },
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
    {
        "andweeb/presence.nvim",
        config = function()
            require("mfaris.plugin-config.presence")
        end,
    },
    -- {
    --     "kylechui/nvim-surround",
    --     version = "*", -- Use for stability; omit to use `main` branch for the latest features
    --     config = function()
    --         require("nvim-surround").setup()
    --     end,
    -- },

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
    -- {
    --     "stevearc/oil.nvim",
    --     config = function()
    --         require("oil").setup({
    --             skip_confirm_for_simple_edits = true,
    --             view_options = {
    --                 show_hidden = true,
    --             },
    --         })
    --     end,
    -- },
}

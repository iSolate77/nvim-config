local picker_opts = { hidden = true, ignored = true, exclude = { "node_modules", ".git" } }
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    -- explorer = { enabled = true },
    gh = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true, layout = { preset = "telescope" }, reverse = false, sources = { gh_pr = {} } },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    -- scroll = { enabled = true },
    statuscolumn = { enabled = false },
    toggle = { enabled = false },
    terminal = { enabled = false },
    -- words = { enabled = true },
  },
  keys = {
    -- find
    { "<leader>fs",  function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
    { "<leader>fb",  function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
    { "<leader>fc",  function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff",  function() Snacks.picker.files(picker_opts) end,                        desc = "Find Files" },
    { "<leader>fg",  function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
    { "<leader>fp",  function() Snacks.picker.projects() end,                                desc = "Projects" },
    { "<leader>fr",  function() Snacks.picker.recent() end,                                  desc = "Recent" },
    -- Grep
    { "<leader>sb",  function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
    { "<leader>sB",  function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
    { "<leader>sg",  function() Snacks.picker.grep(picker_opts) end,                         desc = "Grep" },
    { "<leader>sw",  function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",   mode = { "n", "x" } },
    -- search
    { '<leader>s"',  function() Snacks.picker.registers() end,                               desc = "Registers" },
    { '<leader>s/',  function() Snacks.picker.search_history() end,                          desc = "Search History" },
    { "<leader>sa",  function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
    { "<leader>sc",  function() Snacks.picker.command_history() end,                         desc = "Command History" },
    { "<leader>sC",  function() Snacks.picker.commands() end,                                desc = "Commands" },
    { "<leader>sd",  function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
    { "<leader>sh",  function() Snacks.picker.help() end,                                    desc = "Help Pages" },
    { "<leader>sH",  function() Snacks.picker.highlights() end,                              desc = "Highlights" },
    { "<leader>si",  function() Snacks.picker.icons() end,                                   desc = "Icons" },
    { "<leader>sj",  function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
    { "<leader>sk",  function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
    { "<leader>sl",  function() Snacks.picker.loclist() end,                                 desc = "Location List" },
    { "<leader>sm",  function() Snacks.picker.marks() end,                                   desc = "Marks" },
    { "<leader>sM",  function() Snacks.picker.man() end,                                     desc = "Man Pages" },
    { "<leader>sp",  function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
    { "<leader>sq",  function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
    -- LSP
    -- { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
    -- { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
    { "gr",          function() Snacks.picker.lsp_references() end,                          nowait = true,                       desc = "References" },
    { "gi",          function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
    { "gD",          function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
    { "<leader>ss",  function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
    { "<leader>sS",  function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
    -- Other
    { "<leader>z",   function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
    { "<leader>.",   function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
    { "<leader>S",   function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
    { "<leader>n",   function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
    { "<leader>bd",  function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
    { "<leader>cR",  function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
    { "<leader>gb",  function() Snacks.gitbrowse() end,                                      desc = "Git Browse",                 mode = { "n", "v" } },
    { "<leader>nh",  function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
    -- gh
    { "<leader>ghp", function() Snacks.picker.gh_pr() end,                                   desc = "Github Pull Requests (open)" },
  },
  config = function(_, opts)
    -- Fix for snacks gh module: Set Diff highlight foreground colors BEFORE setup
    -- Catppuccin only defines bg colors for these groups, causing nil fg errors
    vim.api.nvim_set_hl(0, 'DiffAdd', { fg = '#a6e3a1', bg = '#364433' })
    vim.api.nvim_set_hl(0, 'DiffDelete', { fg = '#f38ba8', bg = '#4d2a2e' })
    vim.api.nvim_set_hl(0, 'DiffChange', { fg = '#89b4fa', bg = '#2d3a5c' })

    -- Setup snacks with the provided opts
    require("snacks").setup(opts)

    -- VeryLazy autocmd for debug globals
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
        -- Create some toggle mappings
        -- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        -- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        -- Snacks.toggle.diagnostics():map("<leader>ud")
        -- Snacks.toggle.line_number():map("<leader>ul")
        -- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
        --   "<leader>uc")
        -- Snacks.toggle.treesitter():map("<leader>uT")
        -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        -- Snacks.toggle.inlay_hints():map("<leader>uh")
        -- Snacks.toggle.indent():map("<leader>ug")
        -- Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}

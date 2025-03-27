local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

local swap_next, swap_prev = (function()
  local swap_objects = {
    p = "@parameter.inner",
    f = "@function.outer",
    e = "@element",
    -- Not ready, but I think it's my fault :)
    -- v = "@variable",
  }
  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<M-Space><M-%s>", key)] = obj
    p[string.format("<M-BS><M-%s>", key)] = obj
  end

  return n, p
end)()

configs.setup({
  ensure_installed = { "c", "go", "rust", "python", "html", "javascript", "typescript", "lua", "zig", "proto" }, -- one of "all" or a list of languages
  ignore_install = { "" },                                                                                       -- List of parsers to ignore installing
  highlight = {
    enable = true,                                                                                               -- false will disable the whole extension
    disable = { "" },                                                                                            -- list of language that will be disabled
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },
  additional_vim_regex_highlighting = false,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<M-w>",     -- maps in normal mode to init the node/scope selection
      node_incremental = "<M-w>",   -- increment to the upper named parent
      node_decremental = "<M-C-w>", -- decrement to the previous node
      scope_incremental = "<M-e>",  -- increment to the upper scope (as defined in locals.scm)
    },
  },
  context_commentstring = {
    enable = true,
    -- With Comment.nvim, we don't need to run this on the autocmd.
    -- Only run it in pre-hook
    enable_autocmd = false,
    config = {
      c = "// %s",
      go = "// %s",
      lua = "-- %s",
    },
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]p"] = "@parameter.inner",
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[p"] = "@parameter.inner",
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        -- ["av"] = "@variable.outer",
        -- ["iv"] = "@variable.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = swap_next,
      swap_previous = swap_prev,
    },
  },
})

return {
  "goolord/alpha-nvim",
  config = function()
    local status_ok, alpha = pcall(require, "alpha")
    if not status_ok then
      return
    end

    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      [[             ___                   ]],
      [[           / ___)           _      ]],
      [[  ___ ___ | (__    _ _ _ __(_) ___ ]],
      [[/  _   _  \  __) / _  )  __) |  __)]],
      [[| ( ) ( ) | |   ( (_| | |  | |__  \]],
      [[(_) (_) (_)_)    \__ _)_)  (_)____/]],
      [[                                   ]],
      [[                                   ]],
    }
    dashboard.section.buttons.val = {
      dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button(
        "p",
        " " .. " Find project",
        ":lua require('telescope').extensions.projects.projects()<CR>"
      ),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", " " .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}

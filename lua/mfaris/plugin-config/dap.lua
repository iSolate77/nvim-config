local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)


local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

require('mason-nvim-dap').setup{
  automatic_setup = true,
  ensure_installed = {'cpptools', 'debugpy', 'node-debug2-adapter'},
}

require('mason-nvim-dap').setup_handlers()
--[[ dap_install.setup {} ]]
--[[]]
--[[ dap_install.config("python", {}) ]]
--[[ -- add other configs here ]]
--[[]]
--[[ dap.adapters.python = { ]]
--[[   type = 'executable'; ]]
--[[   command = '/Users/mohdfaris/.local/share/nvim/mason/packages/debugpy/venv/bin/python3.10'; ]]
--[[   args = { '-m', 'debugpy.adapter' }; ]]
--[[ } ]]
--[[ dap.configurations.python = { ]]
--[[   { ]]
--[[     type = 'python'; ]]
--[[     request = 'launch'; ]]
--[[     name = "Launch file"; ]]
--[[     program = "${file}"; ]]
--[[     pythonPath = function() ]]
--[[       return '/opt/homebrew/bin/python3' ]]
--[[     end; ]]
--[[   }, ]]
--[[ } ]]
--[[]]
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/Users/mohdfaris/.local/share/nvim/mason/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  }
}
dap.configurations.rust = dap.configurations.cpp
dap.configurations.c = dap.configurations.cpp
--[[]]
--[[ dap.adapters.node2 = { ]]
--[[   type = 'executable', ]]
--[[   command = 'node', ]]
--[[   args = {'/Users/mohdfaris/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'}, ]]
--[[ } ]]
--[[ dap.configurations.javascript = { ]]
--[[   { ]]
--[[     name = 'Launch', ]]
--[[     type = 'node2', ]]
--[[     request = 'launch', ]]
--[[     program = '${file}', ]]
--[[     cwd = vim.fn.getcwd(), ]]
--[[     sourceMaps = true, ]]
--[[     protocol = 'inspector', ]]
--[[     console = 'integratedTerminal', ]]
--[[   }, ]]
--[[   { ]]
--[[     -- For this to work you need to make sure the node process is started with the `--inspect` flag. ]]
--[[     name = 'Attach to process', ]]
--[[     type = 'node2', ]]
--[[     request = 'attach', ]]
--[[     processId = require'dap.utils'.pick_process, ]]
--[[   }, ]]
--[[ } ]]

dapui.setup {
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
      },
      size = 0.25,
      position = 'right',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
  --[[ sidebar = { ]]
  --[[   elements = { ]]
  --[[     { ]]
  --[[       id = "scopes", ]]
  --[[       size = 0.25, -- Can be float or integer > 1 ]]
  --[[     }, ]]
  --[[     { id = "breakpoints", size = 0.25 }, ]]
  --[[   }, ]]
  --[[   size = 40, ]]
  --[[   position = "right", -- Can be "left", "right", "top", "bottom" ]]
  --[[ }, ]]
  --[[ tray = { ]]
  --[[   elements = {}, ]]
  --[[ }, ]]
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "Snacks" },
            },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
            },
        },
    },
}

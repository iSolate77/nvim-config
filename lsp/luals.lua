return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        'lua',
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
    },
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim', 'snacks' },
            },
            hint = { enable = true },
            runtime = { version = "LuaJIT" },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                },
            },
        },
    },
}

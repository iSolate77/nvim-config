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
            hint = { enable = true },
            workspace = {
                library = {
                    vim.api.nvim_get_runtime_file("", true),
                },
            },
        },
    },
}

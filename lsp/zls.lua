return {
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir' },
    root_markers = { 'zls.json', 'build.zig', '.git' },
    settings = {
        zls = {
            semantic_tokens = "partial",
            zig_exe_path = '/opt/homebrew/bin/zig',
        },
    },
}

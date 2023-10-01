return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
        ensure_installed = {
            java = {
                -- { 'jdtls', version = '1.27.1' },
                "java-debug-adapter",
                "java-test",
            },
        },
    },
}

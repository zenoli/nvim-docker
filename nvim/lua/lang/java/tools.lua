return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
        ensure_installed = {
            java = {
                { "jdtls", version = "1.28.0" },
                "java-debug-adapter",
                "java-test",
            },
        },
    },
}

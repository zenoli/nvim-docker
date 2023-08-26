return {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    build = Noop,
    opts = {
        ensure_installed = {
            "bash",
            "python",
        },
    }

}

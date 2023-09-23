return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = true,
    dependencies = {
        { "williamboman/mason-lspconfig.nvim" },
        {
            "williamboman/mason.nvim",
            opts = { ui = { border = "rounded" } },
            cmd = "Mason",
            build = ":MasonUpdate",
        },
    },
    cmd = {
        "MasonToolsInstall",
        "MasonToolsUpdate",
        "MasonToolsClean",
    },
    opts = {
        ensure_installed = {
            "bash-debug-adapter",
            "bashls",
            "black",
            "debugpy",
            "efm",
            "isort",
            "lua_ls",
            "pyright",
        },
    },
    config = function(_, opts)
        require("mason-tool-installer").setup(opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "MasonToolsStartingInstall",
            callback = function()
                vim.schedule(function()
                    vim.cmd[[normal q]] -- Try closing open floating windows
                    require("mason.ui").open()
                end)
            end,
        })
    end,
    build = Noop,
}

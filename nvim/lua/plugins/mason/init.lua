return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
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
            general = {
                "efm",
                "lua_ls",
            },
        },
    },
    config = function(_, opts)
        -- Merge tool opts
        opts.ensure_installed = vim.tbl_flatten(
            vim.tbl_values(opts.ensure_installed)
        )
        require("mason-tool-installer").setup(opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "MasonToolsStartingInstall",
            callback = function()
                vim.schedule(function()
                    vim.cmd([[normal q]]) -- Try closing open floating windows
                    require("mason.ui").open()
                end)
            end,
        })
    end,
    build = Noop,
}

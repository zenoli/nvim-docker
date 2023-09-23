return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "creativenull/efmls-configs-nvim",
    },
    opts = {
        efm = {
            sh = function()
                return {
                    require("efmls-configs.linters.shellcheck"),
                    require("efmls-configs.formatters.shfmt")
                }
            end,
        },
    },
}

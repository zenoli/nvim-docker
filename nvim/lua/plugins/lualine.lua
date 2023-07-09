return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/tokyonight.nvim" },
    opts = {
        options = {
            theme = "tokyonight",
            disabled_filetypes = {
                statusline = { "neo-tree", "calendar" },
                winbar = {},
            },
            ignore_focus = { "neo-tree", "calendar" },
        },
        sections = {
            lualine_b = { "branch" },
        }
    }
}

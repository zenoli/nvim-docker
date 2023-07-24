return {
    "s1n7ax/nvim-window-picker",
    event = 'VeryLazy',
    version = '2.*',
    opts = {
        -- hint = 'floating-big-letter',
        hint = 'statusline-winbar',
        filter_rules = {
            -- Ignore picker for ft/bt:
            bo = {
                filetype = {
                    "neo-tree",
                    "neo-tree-popup",
                    "notify",
                    "quickfix",
                    "help",
                    "fugitive"
                },
                buftype = { "terminal" },
            },
        },
        highlights = {
            statusline = {
                focused = {
                    fg = '#ededed',
                    bg = '#4493c8',
                    bold = true,
                },
                unfocused = {
                    fg = '#ededed',
                    bg = '#44cc41',
                    bold = true,
                },
            },
        },
    }
}

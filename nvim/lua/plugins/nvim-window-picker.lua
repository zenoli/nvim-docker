return {
    -- only needed if you want to use the commands with "_with_window_picker" suffix
    "s1n7ax/nvim-window-picker",
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
        require("window-picker").setup {
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
    end
}

return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
    },
    keys = require "plugins.neotest.keybindings",
    config = function()
        require "neotest".setup {
            adapters = {
                require "neotest-python" {
                    dap = { justMyCode = false },
                },
            },
        }
    end,
}

return {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = { style = "moon" },
    config = function(_, opts)
        local tokyonight = require("tokyonight")
        print "Setting up tokyonight"
        tokyonight.setup(opts)
        tokyonight.load()
    end,
}

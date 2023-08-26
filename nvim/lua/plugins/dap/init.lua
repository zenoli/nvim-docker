return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "mfussenegger/nvim-dap-python",
    },
    import = "plugins.dap.aux",
    keys = require "plugins.dap.keybindings",
    config = function()
        require "plugins.dap.debug-signs".setup()
        require "plugins.dap.utils".register_dapui_handlers()
    end,
}

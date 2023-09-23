return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "williamboman/mason.nvim",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
    },
    import = "plugins.dap.aux",
    keys = require "plugins.dap.keybindings",
    config = function(_, opts)
        require "plugins.dap.debug-signs".setup()
        require "plugins.dap.utils".register_dapui_handlers()


        -- Setup language specific adapters/configurations defined in `lang/**/dap.lua`
        local dap = require "dap"
        dap.adapters = vim.tbl_extend("force", dap.adapters, opts.adapters)
        dap.configurations = vim.tbl_extend("force", dap.configurations, opts.configurations)
    end,
}

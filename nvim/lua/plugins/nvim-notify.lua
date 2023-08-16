return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
        render = "default",
        stages = "fade",
        timeout = 1000, -- takes a total of 3s (1 fade-in + 1 timeout + 1 fadeout)
    },
    config = function(_, opts)
        local nvim_notify = require "notify"
        nvim_notify.setup(opts)
        vim.notify = nvim_notify
    end,
}

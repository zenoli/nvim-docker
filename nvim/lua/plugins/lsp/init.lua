return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    import = "plugins.lsp.aux",
    event = { "BufReadPre", "BufNewFile" },
    opts = (function()
        local border = "rounded"
        return {
            border = border,
            diagnostics = {
                signs = {
                    { name = "DiagnosticSignError", text = " " },
                    { name = "DiagnosticSignWarn", text = " " },
                    { name = "DiagnosticSignHint", text = " " },
                    { name = "DiagnosticSignInfo", text = " " },
                },
                config = {
                    virtual_text = false,
                    update_in_insert = true,
                    underline = true,
                    severity_sort = true,
                    float = {
                        focusable = false,
                        border = border,
                        style = "minimal",
                        source = "always",
                        header = "",
                        prefix = "",
                    },
                },
            },
        }
    end)(),
    config = function(_, opts)
        local lsp_utils = require "plugins.lsp.utils"
        lsp_utils.setup_keybindings()
        lsp_utils.setup_diagnostics(opts.diagnostics)
        lsp_utils.setup_borders(opts.border)

        require "mason-lspconfig".setup_handlers {
            lsp_utils.get_default_handler(opts),
            ["jdtls"] = function()
                -- TODO
            end,
        }
    end,
}

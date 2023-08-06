return {
    { import = "plugins.lsp.servers" },
    { import = "plugins.lsp.mason" },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            border = "rounded",
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
                        border = "rounded",
                        style = "minimal",
                        source = "always",
                        header = "",
                        prefix = "",
                    },
                }
            }
        },
        config = function(_, opts)
            local lsp_utils = require "plugins.lsp.utils"

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = require("plugins.lsp.keybindings").on_attach
            })

            lsp_utils.setup_diagnostics(opts.diagnostics)
            lsp_utils.setup_borders(opts.border)

            require("mason-lspconfig").setup_handlers({
                lsp_utils.default_handler,
                ["jdtls"] = function()
                    -- TODO
                end
            })
        end
    }
}

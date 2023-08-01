return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    import = "plugins.lsp.mason",
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


        local servers = require("mason-lspconfig").get_installed_servers()
        local skipped_servers = { "jdtls", "tsserver" }
        local filtered_servers = vim.tbl_filter(
            function(server)
                return not vim.tbl_contains(skipped_servers, server)
            end,
            servers
        )

        for _, server in pairs(filtered_servers) do
            require("lspconfig")[server].setup(lsp_utils.get_server_opts(server))
        end

    end
}

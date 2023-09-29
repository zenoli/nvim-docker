return {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        return vim.tbl_deep_extend("force", opts, {
            servers = {
                cssls = {
                    opts = {
                        capabilities = capabilities,
                    },
                },
            },
        })
    end,
}

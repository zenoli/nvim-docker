local M = {}

function M.setup_diagnostics(opts)
    for _, sign in ipairs(opts.signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
    vim.diagnostic.config(opts.config)
end

function M.setup_borders(border)
    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = border })

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
end

function M.get_server_opts(server)
    local has_server_module, server_module =
        pcall(require, "plugins.lsp.servers." .. server)
    if has_server_module then
        return server_module.opts or {}
    end
end

return M

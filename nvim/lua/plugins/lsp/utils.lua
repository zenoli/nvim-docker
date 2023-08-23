local M = {}

local function get_server_config(server)
    local module_found, server_module = pcall(require, "plugins.lsp.servers." .. server)
    local default = {
        setup = Noop,
        opts = {},
    }
    return vim.tbl_extend("force", default, module_found and server_module or {})
end

function M.setup_diagnostics(opts)
    for _, sign in ipairs(opts.signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
    vim.diagnostic.config(opts.config)
end

function M.setup_borders(border)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
end

function M.get_global_opts()
    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if status_ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    else
        vim.notify("cmp_nvim_lsp is not installed...", vim.log.levels.WARN)
    end
    return { capabilities = capabilities }
end

function M.default_handler(server)
    local server_module = get_server_config(server)
    server_module.setup()

    require "lspconfig"[server].setup(
        vim.tbl_deep_extend(
            "force",
            M.get_global_opts(),
            server_module.opts
        )
    )
end

return M

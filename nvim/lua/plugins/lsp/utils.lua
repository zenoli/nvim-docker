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

function M.get_global_opts(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    require("config.utils").if_module(
        "cmp_nvim_lsp",
        function(cmp_nvim_lsp)
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        end,
        { message = "Required for setting up " .. server }
    )
    return { capabilities = capabilities }
end

function M.default_handler(server)
    local server_module = get_server_config(server)
    server_module.setup()

    require "lspconfig"[server].setup(
        vim.tbl_deep_extend(
            "force",
            M.get_global_opts(server),
            server_module.opts
        )
    )
end

return M

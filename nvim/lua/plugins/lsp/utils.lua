local M = {}

local function get_server_config(server)
    local _, server_module = pcall(require, "plugins.lsp.servers." .. server .. ".config")
    local default = {
        setup = Noop,
        opts = {}
    }
    return vim.tbl_extend("force", default, server_module or {})
end

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

function M.get_global_opts()
    -- TODO
    return {}
end

function M.default_handler(server)
    local server_module = get_server_config(server)
    server_module.setup()

    require("lspconfig")[server].setup(vim.tbl_deep_extend(
        "force",
        M.get_global_opts(),
        server_module.opts
    ))
end


return M

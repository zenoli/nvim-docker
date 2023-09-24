local M = {}

function M.setup_keybindings()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(attachEvent)
            require("plugins.lsp.keybindings").setup(attachEvent.buf)
        end,
    })
end

function M.setup_diagnostics(opts)
    for name, icon in pairs(opts.signs) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end
    vim.diagnostic.config(opts.config)
end

function M.setup_borders(border)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
end

function M.get_global_opts()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    require("config.utils").if_module("cmp_nvim_lsp", function(cmp_nvim_lsp)
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end, { message = "Required for setting global lsp options" })
    return { capabilities = capabilities }
end

local function get_server_config(opts, server)
    local default = {
        setup = Noop,
        opts = {},
    }
    return vim.tbl_extend("force", default, opts.servers[server] or {})
end

function M.get_default_handler(opts)
    local global_opts = M.get_global_opts()
    return function(server)
        local server_config = get_server_config(opts, server)
        server_config.setup()

        require("lspconfig")[server].setup(vim.tbl_deep_extend("force", global_opts, server_config.opts))
    end
end

return M

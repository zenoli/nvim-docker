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
        local utils = require "config.utils"
        local lsp_utils = require "plugins.lsp.utils"

        local path = "lua/plugins/lsp/server-settings"
        local stats = utils.read_dir(path)
        for _, setting in ipairs(stats) do
            local module_name = string.gsub(setting.name, ".lua", "")
            require("plugins/lsp/server-settings/" .. module_name)
        end


        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = require("plugins.lsp.keybindings").on_attach
        })

        lsp_utils.setup_diagnostics(opts.diagnostics)
        lsp_utils.setup_borders(opts.border)


        local have_mason, mlsp = pcall(require, "mason-lspconfig")
        local all_mslp_servers = {}
        if have_mason then
            all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
        end
        local lspconfig = require "lspconfig"
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files (WARNING: Slows down the LS significantly)
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }
    end
}

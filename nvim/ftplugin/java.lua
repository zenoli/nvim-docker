-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local mason_utils = require("plugins.mason.utils")
local JDTLS_DIR = mason_utils.mason_package_path() .. "/jdtls"
local JAVA_DEBUG_DIR = mason_utils.mason_package_path() .. "/java-debug-adapter"
local JAVA_TEST_DIR = mason_utils.mason_package_path() .. "/java-test"
-- local JAVA_17_BIN = "/usr/lib/jvm/java-17-openjdk/bin/java"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/home/dev/java_workspace_root/" .. project_name
-- local workspace_dir = vim.fn.getcwd() .. "/.jdtls"

local function get_java_17()
    -- Alternative approach using `update-alternatives`:
    -- update-java-alternatives -l | grep -E 'java.*17' | tr -s ' ' | cut -d ' ' -f3

    local java_17 = vim.fn.system(
        "java_17=$(readlink -f $(which java))"
        .. "&& [[ $java_17 =~ java.*17 ]] "
        .." && echo $java_17"
    )
    if java_17 ~= "" then
        return java_17:gsub("^%s*(.-)%s*$", "%1")
    else
        vim.notify(
            "Java 17 not found. JDTLS will not work",
            vim.log.levels.WARN
        )
        return "java"
    end
end


local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        get_java_17(),
        -- JAVA_17_BIN,
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob(JDTLS_DIR .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        JDTLS_DIR .. "/config_linux",
        "-data",
        workspace_dir,
    },
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew" },

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            signatureHelp = { enabled = true },
            configuration = {
                -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                -- And search for `interface RuntimeOption`
                -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
                runtimes = {
                    -- {
                    --     name = "JavaSE-1.8",
                    --     path = "/usr/lib/jvm/java-8-openjdk-amd64/",
                    -- },
                    -- {
                    --     name = "JavaSE-11",
                    --     path = "/usr/lib/jvm/java-11-openjdk-amd64/",
                    -- },
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk/",
                    },
                },
            },
        },
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.keybindings").setup(bufnr)
        require("jdtls").setup_dap { hotcodereplace = "auto" }
        require("jdtls.dap").setup_dap_main_class_configs()
        require("jdtls.setup").add_commands()

        local dapui = require "dapui"
        local map = require("config.utils").map
        local dap = require "dap"
        dap.listeners.after.event_stopped["dapui_config"] = function() dapui.open() end

        -- keybindings
        map("n", "<leader>jtc", function() require("jdtls").test_class() end)
        map("n", "<leader>jtn", function() require("jdtls").test_nearest_method() end)
    end,

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        -- bundles = {
        --     "/home/olivier/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.41.0.jar"
        -- },
        bundles = vim.list_extend(
            vim.split(
                vim.fn.glob(
                    JAVA_DEBUG_DIR .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"
                ),
                "\n"
            ),
            vim.split(vim.fn.glob(JAVA_TEST_DIR .. "/extension/server/*.jar"), "\n")
        ),
    },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)


local M = {}

function M.map(mode, lhs, rhs, opts)
    opts = opts or {}
    local default_opts = { silent = true }
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", default_opts, opts))
end

function M.read_dir(path)
    local uv = vim.loop
    return uv.fs_readdir(
        uv.fs_opendir(vim.fn.stdpath("config") .. "/" .. path, nil, 1000)
    )
end

return M

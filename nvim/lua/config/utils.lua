local M = {}

function M.map(mode, lhs, rhs, opts)
    opts = opts or {}
    local default_opts = { silent = true }
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", default_opts, opts))
end

return M

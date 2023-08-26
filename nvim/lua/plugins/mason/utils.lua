local M = {}

M.MASON_BIN_PATH = vim.fn.stdpath "data" .. "/mason/bin"
M.MASON_PACKAGE_PATH = vim.fn.stdpath "data" .. "/mason/packages"


function M.mason_bin_path()
    return vim.fn.stdpath "data" .. "/mason/bin"
end

function M.mason_package_path()
    return vim.fn.stdpath "data" .. "/mason/packages"
end

return M


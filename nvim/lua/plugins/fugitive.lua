return {
    "tpope/vim-fugitive",
    cmd = { "Git", "GBrowse" },
    keys = {
        { "<leader>gg",        ":Git<cr>",                             desc = "Launch fugitive" },
        { "<leader>gp",        ":Git push<cr>",                        desc = "git push" },
        { "<leader>gt",        ":Git log --graph --oneline --all<cr>", desc = "git log" },
        { "<leader>gc",        ":Git checkout<space>",                 { silent = false } },
        { "<leader>gb",        ":Git branch<space>",                   { silent = false } },
        { "<leader>g<leader>", ":Git ",                                { silent = false } },
        { "<leader>th",        ":diffget //2<cr> " },
        { "<leader>tl",        ":diffget //3<cr> " }, x
    }
}

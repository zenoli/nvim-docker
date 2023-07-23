return {
    "tpope/vim-fugitive",
    cmd = { "Git", "GBrowse" },
    keys = {
        { "<leader>gg",        ":Git<cr>",                             desc = "Launch fugitive" },
        { "<leader>gp",        ":Git push<cr>",                        desc = "git push" },
        { "<leader>gt",        ":Git log --graph --oneline --all<cr>", desc = "git log" },
        { "<leader>gc",        ":Git checkout<space>",                 desc = "Git checkout" },
        { "<leader>gb",        ":Git branch<space>",                   desc = "Git branch" },
        { "<leader>g<leader>", ":Git ",                                desc = "Git prompt" },
        { "<leader>th",        ":diffget //2<cr> ",                    desc = "Git pick left" },
        { "<leader>tl",        ":diffget //3<cr> ",                    desc = "Git pick right" },
    }
}

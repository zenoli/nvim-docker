return {
    -- Finder bindings
    { "<leader>f",  function() require("telescope.builtin").find_files() end },
    { "<leader>H",
        function()
            require("telescope.builtin").find_files {
                hidden = true,
                prompt_title = "Hidden Files",
            }
        end
    },
    {
        "<leader>I",
        function()
            require("telescope.builtin").find_files {
                hidden = true,
                no_ignore = true,
                prompt_title = "Ignored Files",
            }
        end
    },
    { "<leader>a",  function() require("telescope.builtin").live_grep() end },
    { "<leader>sb", function() require("telescope.builtin").buffers() end },
    { "<leader>sh", function() require("telescope.builtin").help_tags() end },
    { "<leader>sH", function() require("telescope.builtin").highlights() end },
    { "<leader>sc", function() require("telescope.builtin").command_history() end },
    { "<leader>sm", function() require("telescope.builtin").man_pages() end },
    { "<leader>sk", function() require("telescope.builtin").keymaps() end },
    { "<leader>so", function() require("telescope.builtin").lsp_document_symbols() end },
    { "<leader>sO", function() require("telescope.builtin").lsp_workspace_symbols() end },
    { "<leader>st", function() require("telescope.builtin").builtin() end },
    { "<leader>tt", function() require("telescope.builtin").resume() end },
}

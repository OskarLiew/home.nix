---@type MappingsTable
local M = {}

M.general = {
    n = {
        ["<C-d>"] = { "<C-d>zz", "Move half page down and center" },
        ["<C-u>"] = { "<C-u>zz", "Move half page up and center" },
        -- Search terms centered
        ["<n>"] = { "nzzzv" },
        ["<N>"] = { "Nzzzv" },
        ["<leader>y"] = { '"+y', "Yank to clipboard" },
        ["<leader>Y"] = { '"+Y', "Yank row to clipboard" },
        ["<A-n>"] = { "<cmd> cnext <CR>zz", "Next quickfix item" },
        ["<A-p>"] = { "<cmd> cprev <CR>zz", "Previous quickfix item" },
        ["]l"] = { "<cmd> lnext <CR>zz", "Next loclist item" },
        ["[l"] = { "<cmd> lprev <CR>zz", "Previous loclist item" },
    },
    x = {
        ["<leader>p"] = { '"_dP', "Paste and keep buffer" },
    },
    v = {
        ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move selection down" },
        ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move selection up" },
        ["<leader>y"] = { '"+y', "Yank selection to clipboard" },
    },
}

M.disabled = {
    n = {
        -- Clashes with vim-tmux-navigator
        ["<C-h>"] = { "<C-w>h", "Window left" },
        ["<C-l>"] = { "<C-w>l", "Window right" },
        ["<C-j>"] = { "<C-w>j", "Window down" },
        ["<C-k>"] = { "<C-w>k", "Window up" },
    },
}

M.trouble = {
    plugin = true,
    n = {
        ["<leader>xx"] = {
            function()
                require("trouble").toggle()
            end,
            "Toggle diagnostics",
        },
        ["<leader>xw"] = {
            function()
                require("trouble").toggle("workspace_diagnostics")
            end,
            "Workspace diagnostics",
        },
        ["<leader>xd"] = {
            function()
                require("trouble").toggle("document_diagnostics")
            end,
            "Document diagnostics",
        },
        ["<leader>xq"] = {
            function()
                require("trouble").toggle("quickfix")
            end,
            "Quickfix diagnostics",
        },
        ["<leader>xl"] = {
            function()
                require("trouble").toggle("loclist")
            end,
            "Loclist diagnostics",
        },
        ["]x"] = {
            function()
                require("trouble").next({ skip_groups = true, jump = true })
            end,
            "Next trouble",
        },
        ["[x"] = {
            function()
                require("trouble").previous({ skip_groups = true, jump = true })
            end,
            "Previous trouble",
        },
    },
}

M.telescope = {
    plugin = true,
    n = {
        ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Git files" },
        ["<leader>fg"] = { "<cmd> Telescope git_files <CR>", "Git files" },
        ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
        ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "Git status" },
        ["<leader>fm"] = { "<cmd> Telescope marks <CR>", "Find marks" },
        ["<leader>fr"] = { "<cmd> Telescope registers <CR>", "Find registers" },
        ["<leader>cs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Code symbols" },
        ["<leader>cr"] = { "<cmd> Telescope lsp_references <CR>", "LSP references" },
    },
}

M.dap = {
    plugin = true,
    n = {
        ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Breakpoint" },
        ["<leader>dl"] = { "<cmd> DapStepInto <CR>", "Step into" },
        ["<leader>dj"] = { "<cmd> DapStepOver <CR>", "Step over" },
        ["<leader>dh"] = { "<cmd> DapStepOut <CR>", "Step out" },
        ["<leader>dc"] = { "<cmd> DapContinue <CR>", "Continue" },
        ["<leader>dX"] = { "<cmd> DapTerminate <CR>", "Terminate" },
        ["<leader>dd"] = {
            function()
                local ft = vim.bo.filetype
                if ft == "python" then
                    require("dap-python").test_method()
                else
                    error("No dap plugin for " .. ft)
                end
            end,
            "Start debugger",
        },
    },
}

M.undotree = {
    plugin = true,
    n = {
        ["<leader>u"] = { "<cmd> UndotreeToggle <CR>", "Undotree" },
    },
}

M.fugitive = {
    plugin = true,
    n = {
        ["<leader>gg"] = { "<cmd> Git <CR>", "Fugitive" },
        ["<leader>gd"] = { "<cmd> Gdiffsplit <CR>", "Diffsplit" },
        ["<leader>gB"] = { "<cmd> Git blame <CR>", "Blame file" },
        ["<leader>gf"] = { "<cmd> Git log -- %  <CR>", "File history" },
        ["<leader>gl"] = {
            "<cmd> execute 'Git log --format=reference -L ' . line('.') . ',' . line('.') . ':%' <CR>",
            "Line history",
        },
    },
}

M.refactor = {
    n = {
        ["<leader>rr"] = { "<leader>ra", "Rename" },
    },
    v = {
        ["<leader>re"] = { "<cmd> Refactor extract <CR>", "Extract method" },
        ["<leader>rf"] = { "<cmd> Refactor extract_to_file <CR>", "Rxtract method to file" },
        ["<leader>rv"] = { "<cmd> Refactor extract_var <CR>", "Extract variable" },
        ["<leader>ri"] = { "<cmd> Refactor inline_var <CR>", "Inline variable" },
        ["<leader>rb"] = { "<cmd> Refactor extract_block <CR>", "Extract block" },
        ["<leader>rB"] = { "<cmd> Refactor extract_block_to_file <CR>", "Extract block to file" },
    },
}

M.harpoon = {
    plugin = true,
    n = {
        ["<leader>a"] = {
            function()
                require("harpoon.mark").add_file()
            end,
            "add file",
        },
        ["<C-e>"] = {
            function()
                require("harpoon.ui").toggle_quick_menu()
            end,
            "quick menu",
        },
        ["<leader>1"] = {
            function()
                require("harpoon.ui").nav_file(1)
            end,
            "go to file 1",
        },
        ["<leader>2"] = {
            function()
                require("harpoon.ui").nav_file(2)
            end,
            "go to file 2",
        },
        ["<leader>3"] = {
            function()
                require("harpoon.ui").nav_file(3)
            end,
            "go to file 3",
        },
        ["<leader>4"] = {
            function()
                require("harpoon.ui").nav_file(4)
            end,
            "go to file 4",
        },
    },
}

M.crawlerr = {
    n = {
        ["<leader>jn"] = { require("plugins.crawlerr").jump_to_node, "RR jump to node" },
        ["<leader>je"] = {
            function()
                require("plugins.crawlerr").jump_to_texts("en")
            end,
            "Go to node text en",
        },
        ["<leader>js"] = {
            function()
                require("plugins.crawlerr").jump_to_texts("sv")
            end,
            "Go to node text sv",
        },
    },
}

M.filetype_mappings = {
    plugin = true, -- So it's not automatically loaded
    n = {
        ["<leader>e"] = {
            ["python"] = {
                "<cmd> !python % <CR>",
                "Execute python",
            },
            ["lua"] = {
                "<cmd> !lua % <CR>",
                "Execute lua",
            },
            ["rust"] = {
                "<cmd> !cargo run <CR>",
                "Execute rust",
            },
        },
    },
}

-- more keybinds!

return M

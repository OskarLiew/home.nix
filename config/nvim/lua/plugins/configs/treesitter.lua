local options = {
    ensure_installed = { "lua" },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "gn",
            scope_incremental = "gs",
            node_decremental = "gp",
        },
    },
}

return options

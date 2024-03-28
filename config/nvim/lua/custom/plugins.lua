local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require("custom.configs.null-ls")
                end,
            },
        },
        config = function()
            require("plugins.configs.lspconfig")
            require("custom.configs.lspconfig")
        end, -- Override to setup mason-lspconfig
    },

    -- override plugin configs
    {
        "williamboman/mason.nvim",
        opts = overrides.mason,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },

    {
        "NvChad/nvterm",
        enabled = false,
    },

    {
        "folke/which-key.nvim",
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "whichkey")
            require("which-key").setup(opts)
            local present, wk = pcall(require, "which-key")
            if not present then
                return
            end
            wk.register({
                -- add group
                ["<leader>"] = {
                    c = { name = "+code" },
                    d = { name = "+debug" },
                    f = { name = "+find" },
                    h = { name = "+help" },
                    g = { name = "+git" },
                    r = { name = "+refactor" },
                    s = { name = "+settings" },
                    w = { name = "+workspace" },
                    x = { name = "+error" },
                },
            })
        end,
        setup = function()
            require("core.utils").load_mappings("whichkey")
        end,
    },

    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },

    {
        "nvim-treesitter/playground",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        cmd = "TSPlaygroundToggle",
    },

    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },

    {
        "tpope/vim-fugitive",
        event = "BufRead",
        cmd = { "Git", "G" },
    },

    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        event = {
            "BufEnter", -- TODO: Better load criterion
        },
        config = function()
            require("refactoring").setup()
        end,
    },

    {
        "ThePrimeagen/harpoon",
        event = {
            "BufEnter",
        },
    },

    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        enabled = function() -- Load if using tmux
            return os.getenv("TMUX") ~= nil
        end,
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = {
            "BufEnter",
        },
    },
    -- Rust
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = "neovim/nvim-lspconfig",
        opts = function()
            return require("custom.configs.rust-tools")
        end,
        config = function(_, opts)
            require("rust-tools").setup(opts)
        end,
    },
    {
        "saecki/crates.nvim",
        ft = { "rust", "toml" },
        config = function(_, opts)
            local crates = require("crates")
            crates.setup(opts)
            crates.show()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        opts = function()
            local M = require("plugins.configs.cmp")
            table.insert(M.sources, { name = "crates" })
            return M
        end,
    },

    -- Debugging
    {
        "mfussenegger/nvim-dap",
        config = function(_, opts)
            require("core.utils").load_mappings("dap")
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function(_, opts)
            local path = "$XDG_DATA_HOME/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapup_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },

    {
        "tpope/vim-surround",
        event = {
            "BufEnter",
        },
    },

    -- To make a plugin not be loaded
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },

    -- All NvChad plugins are lazy-loaded by default
    -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
    -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
    -- {
    --   "mg979/vim-visual-multi",
    --   lazy = false,
    -- }
}

return plugins

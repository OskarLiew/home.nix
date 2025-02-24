local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- if you just want default config for the servers then put them in a table
local servers = {
    "html",
    "cssls",
    "tsserver",
    "clangd",
    "nil_ls",
    "gopls",
    "pyright",
    "bashls",
    "docker_compose_language_service",
    "dockerls",
    "phpactor",
    "taplo",
    "yamlls",
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "rust" },
    root_dir = util.root_pattern("Cargo.toml"),
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
        },
    },
})

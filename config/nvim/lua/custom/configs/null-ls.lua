local null_ls = require("null-ls")
local h = require("null-ls.helpers")
local u = require("null-ls.utils")
local methods = require("null-ls.methods")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local b = null_ls.builtins

local ruff_format = h.make_builtin({
    name = "ruff-format",
    method = methods.internal.FORMATTING,
    filetypes = { "python" },
    generator_opts = {
        command = "ruff",
        args = {
            "format",
            "-n",
            "--stdin-filename",
            "$FILENAME",
            "-",
        },
        to_stdin = true,
        cwd = h.cache.by_bufnr(function(params)
            return u.root_pattern("pyproject.toml")(params.bufname)
        end),
    },
    factory = h.formatter_factory,
})

local ruff_isort = h.make_builtin({
    name = "ruff-isort",
    method = methods.internal.FORMATTING,
    filetypes = { "python" },
    generator_opts = {
        command = "ruff",
        args = {
            "--fix",
            "--select",
            "I001", -- Import sorting
            "-n",
            "--stdin-filename",
            "$FILENAME",
            "-",
        },
        to_stdin = true,
        cwd = h.cache.by_bufnr(function(params)
            return u.root_pattern("pyproject.toml")(params.bufname)
        end),
    },
    factory = h.formatter_factory,
})

local sources = {

    -- webdev stuff
    b.formatting.deno_fmt, -- deno for ts/js files is very fast
    b.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }), -- so prettier works only on these filetypes

    -- Lua
    b.formatting.stylua,

    -- cpp
    b.formatting.clang_format,

    -- Python
    -- b.diagnostics.mypy,
    b.diagnostics.ruff.with({
        extra_args = { "--ignore", "F821,F841,F401,B018" },
    }),
    ruff_format,
    ruff_isort,
}

local function format_on_save(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

null_ls.setup({
    debug = true,
    sources = sources,
    on_attach = format_on_save,
})

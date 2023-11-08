local lsp_zero = require("lsp-zero").preset({})
local lsp_config = require("lspconfig")

local cmp = require("cmp")
cmp.setup({
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-Space>"] = cmp.mapping.complete(),
    },
})

lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr, omit = { "<F3>", "<F4>" } })
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
end)

lsp_config.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                -- formatter options
                black = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                -- linter options
                pylint = { enabled = false },
                pyflakes = { enabled = false },
                pydocstyle = { enabled = false },
                pycodestyle = { enabled = false },
                -- type checker
                pylsp_mypy = { enabled = true },
            }
        }
    }
}

lsp_zero.setup_servers({
    "dartls",
    "tsserver",
    "eslint",
    "lua_ls",
    "intelephense",
    "clangd",
    "texlab",
    "tailwindcss",
    -- "pyright",
    "java_language_server",
    "ruff_lsp",
})

lsp_zero.setup()

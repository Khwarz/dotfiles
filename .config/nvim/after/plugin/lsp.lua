local lsp_zero = require("lsp-zero").preset({
    manage_nvim_cmp = {
        set_extra_mappings = true,
    }
})
local lsp_config = require("lspconfig")

lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr, omit = { "<F3>", "<F4>" } })
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
    vim.keymap.set("n", "<leader>aa", vim.fn.setloclist)
end)

lsp_zero.setup_servers({
    "dartls",
    "tsserver",
    "eslint",
    "intelephense",
    "clangd",
    "texlab",
    "lua_ls",
    "tailwindcss",
    -- "pyright",
    "java_language_server",
    "ruff_lsp",
})

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


lsp_zero.setup()

local cmp = require("cmp")
local cmp_action = require('lsp-zero').cmp_action()

require("luasnip").filetype_extend("python", { "django" })
require("luasnip").filetype_extend("html", { "djangohtml" })

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

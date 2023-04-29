local lsp = require("lsp-zero").preset({})

local cmp = require('cmp')
cmp.setup({
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }
})

lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr, omit = { '<F3>', '<F4>' } })
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
end)

lsp.setup_servers({
    'dartls',
    'tsserver',
    'eslint',
    'lua_ls',
    'pylsp',
    'intelephense',
    'clangd',
    'texlab',
})

lsp.setup()

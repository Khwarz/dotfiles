local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
require("lsp-format").setup {}

local opts = {
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.djhtml,
    },
    debug = false,
    on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
}

null_ls.setup(opts)

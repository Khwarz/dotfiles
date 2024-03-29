local autocmd = vim.api.nvim_create_autocmd

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.cursorline = true

-- vim.opt.colorcolumn = 50

vim.g.mapleader = " "

autocmd("BufRead,BufNewFile", {
	pattern = "*.blade.php",
	command = "set filetype=html",
})

autocmd("DiagnosticChanged", {
    callback = function(args)
        vim.diagnostic.setloclist({ open = false })
    end
})

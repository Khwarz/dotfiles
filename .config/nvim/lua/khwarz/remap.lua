vim.keymap.set("n", "<leader>d", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "]b",vim.cmd.bnext)
vim.keymap.set("n", "[b",vim.cmd.bprev)
vim.keymap.set("n", "]B",vim.cmd.bfirst)
vim.keymap.set("n", "[B",vim.cmd.blast)

vim.keymap.set("n", "]a",vim.cmd.next)
vim.keymap.set("n", "[a",vim.cmd.prev)
vim.keymap.set("n", "]A",vim.cmd.first)
vim.keymap.set("n", "[A",vim.cmd.last)

vim.keymap.set("n", "]t",vim.cmd.tabn)
vim.keymap.set("n", "[t",vim.cmd.tabp)

vim.keymap.set("n", "<leader>f", vim.cmd.Format)

-- vim.keymap.set("n", "gf", "<cmd>diffget //2<cr>")
-- vim.keymap.set("n", "gh", "<cmd>diffget //3<cr>")

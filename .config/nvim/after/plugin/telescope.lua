local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", ":Telescope git_files<CR>", {})
vim.keymap.set("n", "<leader><leader>", builtin.buffers, {})
vim.keymap.set("n", "<leader>ss", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

require("telescope").setup({
    pickers = {
        find_files = {
            disable_devicons = true,
            previewer = false,
        },
        buffers = {
            disable_devicons = true,
            previewer = false,
        },
        git_files = {
            disable_devicons = true,
            previewer = false,
        }
    },
    defaults = {
        mappings = {
            i = {
                ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            },
        },
    },
})

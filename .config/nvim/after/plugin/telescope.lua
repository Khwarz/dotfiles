local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader><leader>", builtin.buffers, {})
vim.keymap.set("n", "<leader>ss", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<c-d>"] = actions.delete_buffer + actions.move_to_top,
			},
		},
	},
})

require("formatter").setup({
	logging = true,
	filetype = {
		dart = {
			require("formatter.filetypes.dart").dartformat,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},
		javascriptreact = {
			require("formatter.filetypes.javascriptreact").prettier,
		},
		php = {
			function()
				return {
					exe = "pint",
				}
			end,
		},
		python = {
			require("formatter.filetypes.python").isort,
			require("formatter.filetypes.python").black,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettier,
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettier,
		},
	},
})

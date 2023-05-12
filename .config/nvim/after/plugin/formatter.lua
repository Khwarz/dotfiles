require("formatter").setup {
    logging = true,
    filetype = {
        lua = {
            require("formatter.filetypes.lua").stylua,
        },
        php = {
            function ()
                return {
                    exe = "pint",
                }
            end
        }
    },
}

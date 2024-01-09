vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use({ "projekt0n/github-nvim-theme", tag = "v1.0.1" })
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use("nvim-treesitter/playground")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use({ 'hrsh7th/cmp-buffer' })
    use({ 'hrsh7th/cmp-path' })
    use({ 'hrsh7th/cmp-cmdline' })
    use({ 'hrsh7th/nvim-cmp' })
    use({ "rafamadriz/friendly-snippets" })
    use({ "saadparwaiz1/cmp_luasnip" })
    use(
        {
            "L3MON4D3/LuaSnip",
            tag = "v2.*",
            run = "make install_jsregexp",
        } -- Required
    )
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            {
                -- Optional
                "williamboman/mason.nvim",
                run = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
        },
    })
    use({
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    })
    use({ "mfussenegger/nvim-dap" })
    use({
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui"
        },
        config = function(_, opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end
    })
    use({ "nvimtools/none-ls.nvim" })
    use({ "thosakwe/vim-flutter" })
    use({
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
    })
    use({ "lervag/vimtex" })
    use({ "christoomey/vim-tmux-navigator" })
    use({ "m4xshen/hardtime.nvim" })
end)

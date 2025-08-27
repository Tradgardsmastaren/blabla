-- Installs Lazy if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'hrsh7th/nvim-cmp',                                         -- Completetion
    'hrsh7th/cmp-path',                                         -- Add PATH to cmp-sources
    'hrsh7th/cmp-nvim-lsp',                                     -- Add LSP to cmp-sources
    'hrsh7th/cmp-omni',                                         -- Completetion for LaTeX
    'saadparwaiz1/cmp_luasnip',                                 -- Add snippets to cmp-sources
    'L3MON4D3/LuaSnip',                                         -- Snippets
    'rafamadriz/friendly-snippets',                             -- Default snippets
    'neovim/nvim-lspconfig',                                    -- LSP
    { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" }, -- Syntax highlighting
    'folke/tokyonight.nvim',                                    -- Colorscheme
    'windwp/nvim-autopairs',                                    -- Auto () {} [] "" ''
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },                                                      -- Fzf
    'nvim-telescope/telescope-file-browser.nvim',
    'lervag/vimtex',                                        -- LaTeX things
    { 'echasnovski/mini.surround',       version = false }, -- Surround
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },


})

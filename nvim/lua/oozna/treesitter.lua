local configs = require('nvim-treesitter.configs')

configs.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highligting = true,
    },
    indent = {
        enable = true, disable = { "yaml" }
    }
}

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

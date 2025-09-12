return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",      -- required
    "sindrets/diffview.nvim",     -- optional
  },
  keys = {
    {
      "<leader>gg",
      function()
        require('neogit').open()
      end,
      desc = "Open Neogit",
    },
  },
}



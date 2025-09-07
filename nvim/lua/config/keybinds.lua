------------------------------- SETTINGS -------------------------------
--Space as leader
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.localleader = " "

-- Copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yank" })
vim.keymap.set("n", "<leader>D", '"_D', { desc = "Delete line without yank" })

-- Paste without affecting the unnamed register
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Paste over without yanking" })

-- Window navigation
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wl", "<C-w>l")

-- Window Splits
vim.keymap.set("n", "<leader>wv", "<C-w>v")
vim.keymap.set("n", "<leader>ws", "<C-w>s")

-- Window delete
vim.keymap.set("n", "<leader>wd", "<C-w>q")
vim.keymap.set("n", "<leader>wo", "<C-w>o")

-- Stay selected after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Doom bindings
vim.keymap.set('n', '<leader>fs', ':w<CR>')

-- Buffer management
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>')
vim.keymap.set('n', '<leader>bn', ':bnext<CR>')
vim.keymap.set('n', '<leader>bk', ':bdelete<CR>')



vim.keymap.set({'n', 'v'} , 'ö', ':')

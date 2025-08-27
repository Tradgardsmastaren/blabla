-- Keybindings

--Space as leader
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.localleader = " "

-- Moving lines up and down
vim.keymap.set("n", "ª", ":m .-2<CR>==")
vim.keymap.set("n", "√", ":m .+1<CR>==")
vim.keymap.set("i", "ª", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "√", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("v", "ª", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "√", ":m '>+1<CR>gv=gv")

-- Keep in center when scrolling/searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>D", "\"_D")

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<leader>wl", "<C-w>l")

-- Window Splits
vim.keymap.set("n", "<leader>wv", "<C-w>v")
vim.keymap.set("n", "<leader>ws", "<C-w>s")

-- Window delete
vim.keymap.set("n", "<leader>wd", "<C-w>q")
vim.keymap.set("n", "<leader>wc", "<C-w>q")
vim.keymap.set("n", "<leader>wD", "<C-w>o")
vim.keymap.set("n", "<leader>wC", "<C-w>o")

-- Arrow Resize, doesn't work on mac ATM
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertival_resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertival_resize +2<CR>")

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")

-- Stay selected after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files()<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>lua require'telescope.builtin'.live_grep()<cr>")
vim.keymap.set("n", "<leader>bb", "<cmd>lua require'telescope.builtin'.buffers()<cr>")
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>lua require'telescope.builtin'.help_tags()<cr>")

-- DOOM keybinds
vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>")


-- Easier search and replace
vim.keymap.set("n", "<leader>s", ":s/")
vim.keymap.set("n", "<leader>S", ":%s/")
vim.keymap.set("v", "<leader>s", ":'<,'>s/")

-- Mark switch
vim.keymap.set("n", "'", "`")
vim.keymap.set("n", "`", "'")

-- Testing if this is nice
vim.keymap.set("n", "ö", ":")

vim.keymap.set("i", "jk", "<Esc>")

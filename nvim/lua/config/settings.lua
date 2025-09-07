------------------------------- SETTINGS -------------------------------
vim.opt.number = true             -- Numbers
vim.opt.relativenumber = true     -- Relative

local tab_length = 2              -- Tabs
vim.opt.shiftwidth = tab_length   -- Nr of spaces
vim.opt.tabstop = tab_length      -- Nr of spaces 
vim.opt.softtabstop = tab_length  -- Nr of spaces
vim.opt.expandtab = true          -- Spaces instead of tabs
vim.opt.smartindent = true        -- Automatically inserts appropriate indentation on new lines

-- Search options
vim.opt.ignorecase = true         -- Case insensitive
vim.opt.smartcase = true          -- Unless you have Uppercase
vim.opt.incsearch = true          -- Move as you search
vim.opt.hlsearch = false          -- No ugly highlighting

vim.opt.swapfile = false          -- Disable Swapfile
vim.opt.wrap = false              -- No text-wrap
vim.opt.termguicolors = true      -- Idk what this does


vim.opt.signcolumn = "yes:1"      -- Make diagnostic not flip everything
vim.g.have_nerd_font = true       -- Idk what this does

-- Splits
vim.opt.splitbelow = true         -- Horizontal splits always below
vim.opt.splitright = true         -- Vertical splits always to the right

vim.opt.updatetime = 300          -- Faster completions (4000 default)
vim.opt.undofile = true           -- Enables persistent undo

vim.opt.scrolloff = 8             -- Scrolloff
vim.opt.sidescrolloff = 8         -- Same but Horizontal

-- 
vim.opt.fillchars = { eob = " " } -- Delete ~ at EOF 

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better buffer navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move vertically by visual line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("v", "j", "gj", opts)
keymap("v", "k", "gk", opts)

-- Swap record and back-work keys
-- I do this because lining up QWE for navigating words makes sense
-- to me, and I always miss the b key. I also do not use the record
-- function very often
keymap("n", "q", "b", opts)
keymap("n", "b", "q", opts)
keymap("v", "q", "b", opts)
keymap("v", "b", "q", opts)

-- Move to the beginning/end of a line
-- this will overwrite two existing movement hotkeys
keymap("n", "Q", "^", opts)
keymap("n", "E", "$", opts)
keymap("n", "$", "<nop>", opts)
keymap("n", "^", "<nop>", opts)
keymap("v", "Q", "^", opts)
keymap("v", "E", "$", opts)
keymap("v", "$", "<nop>", opts)
keymap("v", "^", "<nop>", opts)

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap({"n", "v"}, "<leader>yc", "\"+y", opts) -- Copy to system clipboard
keymap({"n", "v"}, "<leader>yf", "<cmd>%y+<cr>", opts) -- Copy entire file to system clipboard
keymap({"n", "v"}, "<leader>pc", "\"+p", opts) -- Paste from system clipboard
keymap({"n", "v"}, "<leader>pf", "ggVG\"+p", opts) -- Paste entire file from system clipboard (aka delete all then paste from clipboard)

keymap("n", "<leader>a", "ggVG", opts) -- Select all

keymap({"n", "v"}, "H", "^", opts) -- Cursor to first non-whitespace character of line
keymap({"n", "v"}, "L", "$", opts) -- Cursor to end of line

keymap("n", "<leader>qs", "ciw'<C-r>\"'<Esc>", opts) -- Surround word in single quotes
keymap("n", "<leader>qd", 'ciw"<C-r>""<Esc>', opts) -- Surround word in double quotes
keymap("v", "<leader>qs", "c'<C-r>\"'<Esc>", opts) -- Surround selection in single quotes
keymap("v", '<leader>qd', 'c"<C-r>""<Esc>', opts) -- Surround selection in double quotes
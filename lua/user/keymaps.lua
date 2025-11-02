local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap({ "n", "v" }, "<leader>yc", '"+y', opts) -- Copy to system clipboard
keymap({ "n", "v" }, "<leader>yf", "<cmd>%y+<cr>", opts) -- Copy entire file to system clipboard
keymap({ "n", "v" }, "<leader>pc", '"+p', opts) -- Paste from system clipboard
keymap({ "n", "v" }, "<leader>pf", 'ggVG"+p', opts) -- Paste entire file from system clipboard (aka delete all then paste from clipboard)

keymap("n", "<leader>a", "ggVG", opts) -- Select all

keymap({ "n", "v" }, "H", "^", opts) -- Cursor to first non-whitespace character of line
keymap({ "n", "v" }, "L", "$", opts) -- Cursor to end of line

keymap("n", "<leader>qs", "ciw'<C-r>\"'<Esc>", opts) -- Surround word in single quotes
keymap("n", "<leader>qd", 'ciw"<C-r>""<Esc>', opts) -- Surround word in double quotes
keymap("v", "<leader>qs", "c'<C-r>\"'<Esc>", opts) -- Surround selection in single quotes
keymap("v", "<leader>qd", 'c"<C-r>""<Esc>', opts) -- Surround selection in double quotes

keymap("n", ";", "$a;<Esc>", opts) -- Append line with semi-colon

keymap("n", "<C-e>", ":Neotree filesystem reveal left<CR>", opts)

-- LSP keymaps
keymap("n", "K", vim.lsp.buf.hover, opts) -- Hover info
keymap("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
keymap("n", "gh", vim.diagnostic.open_float, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, {}) -- Code actions
keymap("n", "<leader>gf", vim.lsp.buf.format, {}) -- Format

-- Tabline (barbar) keymaps
-- Move to previous/next
keymap('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
keymap('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

-- Re-order to previous/next
keymap('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
keymap('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

-- Goto buffer in position...
keymap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
keymap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
keymap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
keymap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
keymap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
keymap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
keymap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
keymap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
keymap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
keymap('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

keymap('n', '<a-c>', "<Cmd>BufferClose<CR>", opts)

-- C++ compile and run
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		-- Detect OS
		local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
		local exe_ext = is_windows and ".exe" or ""
		local run_prefix = is_windows and "" or "./"

		-- Set makeprg
		vim.opt_local.makeprg = "g++ -std=c++23 -Wall -Wextra % -o %:r" .. exe_ext

		-- Compile only
		vim.keymap.set("n", "<F5>", ":w<CR>:make<CR>:copen<CR>", { buffer = true, desc = "Compile C++" })

		-- Compile and run
		vim.keymap.set("n", "<F6>", function()
			vim.cmd("w")
			vim.cmd("make")
			if vim.fn.empty(vim.fn.getqflist()) then
				local output = vim.fn.expand("%:r") .. ".exe"
				vim.cmd("belowright vsplit | terminal " .. output) -- Changed this line
			else
				vim.cmd("copen")
			end
		end, { buffer = true, desc = "Compile and run C++" })
	end,
})

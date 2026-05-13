return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter")
		local parsers = {
			"rust",
			"javascript",
			"lua",
			"python",
			"c_sharp",
			"cpp",
		}

		config.setup({
			highlight = { enable = true },
			indent = { enable = true },
			fold = { enable = true },
		})

		local has_tree_sitter_cli = vim.fn.executable("tree-sitter") == 1
		local has_compiler = vim.fn.executable("clang") == 1
			or vim.fn.executable("gcc") == 1
			or vim.fn.executable("cc") == 1
			or vim.fn.executable("cl") == 1
			or vim.fn.executable("zig") == 1
			or vim.fn.executable("g++") == 1

		if has_tree_sitter_cli and has_compiler then
			pcall(config.install, parsers)
		end
	end,
}

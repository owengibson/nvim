return {
	"HiPhish/rainbow-delimiters.nvim",
	init = function()
		vim.g.rainbow_delimiters = {
			condition = function(bufnr)
				local buftype = vim.bo[bufnr].buftype
				local filetype = vim.bo[bufnr].filetype
				return buftype == "" and filetype ~= "alpha"
			end,
		}
	end,
}

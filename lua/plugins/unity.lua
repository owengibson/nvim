return {
	{
		"apyra/nvim-unity-sync",
		dependencies = {
			"nvim-tree/nvim-tree.lua",
		},
		ft = { "cs" },
		enabled = function()
			local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
			if is_windows then
				return false
			end

			return pcall(require, "nvim-tree.api")
		end,
	},
}

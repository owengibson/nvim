return {
	{
		"apyra/nvim-unity-sync",
		dependencies = {
			"nvim-tree/nvim-tree.lua",
		},
		lazy = false,
		config = function()
			require("unity.plugin").setup()
		end,
	},
}

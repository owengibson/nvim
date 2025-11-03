return {
	{
		"apyra/nvim-unity-sync",
		lazy = false,
		config = function()
			require("unity.plugin").setup()
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		lazy = false,
		config = function()
			require("project_nvim").setup({})
		end,
	},
}

return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local sources = {}

		local function add_if_executable(command, source)
			if vim.fn.executable(command) == 1 then
				sources[#sources + 1] = source
			end
		end

		add_if_executable("stylua", null_ls.builtins.formatting.stylua)
		add_if_executable("black", null_ls.builtins.formatting.black)
		add_if_executable("clang-format", null_ls.builtins.formatting.clang_format)
		add_if_executable("prettier", null_ls.builtins.formatting.prettier)
		add_if_executable("pylint", null_ls.builtins.diagnostics.pylint)
		add_if_executable("cpplint", require("none-ls.diagnostics.cpplint"))

		null_ls.setup({
			sources = sources,
		})
	end,
}

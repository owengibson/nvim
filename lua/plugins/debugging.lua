return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {
				"nvim-neotest/nvim-nio",
			},
		},
	},

	config = function()
		local dap = require("dap")
		local ok_dapui, dapui = pcall(require, "dapui")

		local function split_version(version)
			local parts = {}
			for num in version:gmatch("%d+") do
				parts[#parts + 1] = tonumber(num)
			end
			return parts
		end

		local function compare_versions(left, right)
			local left_parts = split_version(left)
			local right_parts = split_version(right)
			local max_parts = math.max(#left_parts, #right_parts)

			for idx = 1, max_parts do
				local left_value = left_parts[idx] or 0
				local right_value = right_parts[idx] or 0

				if left_value ~= right_value then
					return left_value > right_value
				end
			end

			return left > right
		end

		local function find_unity_debug_adapter()
			local pattern = vim.fn.expand("$HOME") .. "/.vscode/extensions/visualstudiotoolsforunity.vstuc-*"
			local extension_dirs = vim.fn.glob(pattern, false, true)
			local best_dir
			local best_version

			for _, dir in ipairs(extension_dirs) do
				local version = dir:match("vstuc%-(%d+%.%d+%.%d+)$")
				local adapter = dir .. "/bin/UnityDebugAdapter.dll"

				if version and vim.uv.fs_stat(adapter) and (not best_version or compare_versions(version, best_version)) then
					best_dir = dir
					best_version = version
				end
			end

			if not best_dir then
				return nil
			end

			return best_dir .. "/bin/UnityDebugAdapter.dll"
		end

		local unity_debug_adapter = find_unity_debug_adapter()

		if unity_debug_adapter and vim.fn.executable("dotnet") == 1 then
			dap.adapters.vstuc = {
				type = "executable",
				command = "dotnet",
				args = { unity_debug_adapter },
				name = "Attach to Unity",
			}

			dap.configurations.cs = {
				{
					type = "vstuc",
					request = "attach",
					name = "Attach to Unity Editor",
					logFile = vim.fn.stdpath("data") .. "/vstuc.log",
					endPoint = "127.0.0.1:56864",
				},
			}
		end

		if ok_dapui then
			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<F5>", dap.continue, {})
		vim.keymap.set("n", "<F10>", dap.step_into, {})
		vim.keymap.set("n", "<F11>", dap.step_over, {})
		vim.keymap.set("n", "<F12>", dap.step_out, {})

		dap.set_log_level("TRACE")

		-- Define custom signs
		vim.fn.sign_define("DapBreakpoint", {
			text = "🔴",
			texthl = "DapBreakpoint",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapStopped", {
			text = "▶️",
			texthl = "DapStopped",
			linehl = "DapStoppedLine",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointRejected", {
			text = "🚫",
			texthl = "DapBreakpoint",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointCondition", {
			text = "🔶",
			texthl = "DapBreakpoint",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapLogPoint", {
			text = "📝",
			texthl = "DapLogPoint",
			linehl = "",
			numhl = "",
		})
	end,
}

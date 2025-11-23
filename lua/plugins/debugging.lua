return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Path to vstuc extension (adjust version number as needed)
		local vstuc_path = vim.fn.expand("$HOME") .. "/.vscode/extensions/visualstudiotoolsforunity.vstuc-1.1.3/bin/"

		-- Configure the adapter
		dap.adapters.vstuc = {
			type = "executable",
			command = "dotnet", -- Uses .NET, not mono!
			args = { vstuc_path .. "UnityDebugAdapter.dll" },
			name = "Attach to Unity",
		}

		-- Configure Unity debugging
		dap.configurations.cs = {
			{
				type = "vstuc",
				request = "attach",
				name = "Attach to Unity Editor",
				logFile = vim.fn.stdpath("data") .. "/vstuc.log",
				endPoint = "127.0.0.1:56864",
			},
		}

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

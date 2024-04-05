return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		{ "jay-babu/mason-nvim-dap.nvim" },
	},
	ft = { "go", "c", "cpp", "rust", "zig", "python" },
	config = function()
		local dap, dap_ui, mason_dap = require("dap"), require("dapui"), require("mason-nvim-dap")

		dap_ui.setup()

		mason_dap.setup({
			ensure_installed = {
				"python",
				"delve",
				"cppdbg",
			},
			handlers = {
				function(config)
					mason_dap.default_setup(config)
				end,
			},
		})

		-- dapui setup
		dap.listeners.before.attach.dapui_config = function()
			dap_ui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			dap_ui.open()
		end

		dap.listeners.before.event_terminated.dapui_config = function()
			dap_ui.close()
		end

		dap.listeners.before.event_exited.dapui_config = function()
			dap_ui.open()
		end

		-- keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
		keymap.set("n", "<leader>dc", dap.continue, { desc = "Launch/Continue debug execution" })
		keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
		keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
		keymap.set("n", "<leader>ds", dap.stop, { desc = "Stop" })
		keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
	end,
}

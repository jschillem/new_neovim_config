return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"leoluz/nvim-dap-go",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		{ "jay-babu/mason-nvim-dap.nvim" },
	},
	ft = { "go", "c", "cpp", "rust", "zig" },
	config = function()
		local dap = require("dap")
		local dap_ui = require("dapui")
		local mason_dap = require("mason-nvim-dap")

		dap.adapters.godot = {
			type = "server",
			host = "127.0.0.1",
			port = 6006,
		}

		dap.configurations.gdscript = {
			{
				type = "godot",
				request = "launch",
				name = "Launch scene",
				project = "${workspaceFolder}",
				stopOnEntry = true,
			},
		}

		dap_ui.setup()
		require("dap-go").setup()

		mason_dap.setup({
			ensure_installed = {
				"python",
				"delve",
				"cppdbg",
			},
			automatic_installation = true,
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
		keymap.set("n", "<leader>du", dap.step_out, { desc = "Step out" })
		keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
		keymap.set("n", "<leader>ds", dap.close, { desc = "Close" })
		keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
	end,
}

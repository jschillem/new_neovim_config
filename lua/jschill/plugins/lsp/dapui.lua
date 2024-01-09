local dap_status, dap = pcall(require, "dap")

local ui_status, dap_ui = pcall(require, "dapui")
if not ui_status then
	return
end

dap_ui.setup()

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
	dap_ui.close()
end

local status, copilot = pcall(require, "copilot")
if not status then
	return
end

copilot.setup({
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = "<M-a>",
		},
	},
})

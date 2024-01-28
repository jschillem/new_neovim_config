local status, copilot = pcall(require, "copilot")
if not status then
	return
end

local cmp_status, cp_cmp = pcall(require, "copilot_cmp")

copilot.setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})
cp_cmp.setup({})

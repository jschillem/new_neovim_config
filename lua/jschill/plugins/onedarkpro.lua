local status, onedarkpro = pcall(require, "onedarkpro")
if not status then
	return
end

onedarkpro.setup({
	colors = {
		cursorline = "#22262D", -- This is optional. The default cursorline color is based on the background
	},
	options = {
		cursorline = true,
	},
})

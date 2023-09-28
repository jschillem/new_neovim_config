local status, indent = pcall(require, "ibl")
if not status then
	return
end

indent.setup({
	exclude = {
		filetypes = {
			"lspinfo",
			"packer",
			"checkhealth",
			"help",
			"man",
			"dashboard",
		},
	},
})

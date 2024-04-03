local status, signature = pcall(require, "lsp_signature")
if not status then
	return
end

signature.setup({
	hint_prefix = "",
	floating_window = true,
	doc_lines = 0,
	bind = true,
	hint_enable = false,
	handler_opts = {
		border = "single",
	},
})

local status, conform = pcall(require, "conform")

conform.setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

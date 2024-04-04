return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup()

		mason_lspconfig.setup({
			ensure_installed = {
				"tsserver",
				"html",
				"htmx",
				"cssls",
				"tailwindcss",
				"astro",
				"svelte",
				"lua_ls",
				"emmet_language_server",
				"pyright",
				"ruff_lsp",
				"clangd",
				"gopls",
				"templ",
				"rust_analyzer",
				"taplo",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"eslint_d",
				"stylua",
				"curlylint",
			},
		})
	end,
}

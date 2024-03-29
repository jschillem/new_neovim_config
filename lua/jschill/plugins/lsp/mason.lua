local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mason_null_ls_setup, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_setup then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		"tsserver",
		"gopls",
		"clangd",
		"html",
		"cssls",
		"rust_analyzer",
		"pylsp",
		"lua_ls",
		"taplo",
	},
	automatic_installation = true,
})

mason_null_ls.setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"gofmt",
	},
})

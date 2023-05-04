local status, indent = pcall(require, "indent_blankline")
if not status then
	return
end

vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_filetype_exclude = {
	"lspinfo",
	"packer",
	"checkhealth",
	"help",
	"man",
	"dashboard",
}

indent.setup({})

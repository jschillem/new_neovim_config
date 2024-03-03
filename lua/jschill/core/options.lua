local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentations
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cs",
	callback = function()
		opt.tabstop = 4
		opt.shiftwidth = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		opt.tabstop = 4
		opt.shiftwidth = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	callback = function()
		opt.tabstop = 2
		opt.shiftwidth = 2
	end,
})

-- detect wgsl files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.wgsl",
	callback = function()
		vim.bo.filetype = "wgsl"
	end,
})

-- rust settings
vim.g.rust_recommended_style = 0
vim.g.rustfmt_autosave = 1

-- scroll off
opt.scrolloff = 8

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- remove line wrapping / auto newline
opt.textwidth = 130
opt.formatoptions = opt.formatoptions + "t" + "c"

opt.iskeyword:append("-")

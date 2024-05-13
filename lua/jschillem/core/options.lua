vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

vim.g.have_nerd_font = true

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- turn on termguicolors
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

-- add not detected filetypes
vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({ extension = { wgsl = "wgsl" } })
vim.filetype.add({ extension = { edgedb = "esdl" } })
vim.filetype.add({ extension = { roc = "roc" } })
vim.filetype.add({
	pattern = {
		[".*%.blade.php"] = "blade",
	},
})

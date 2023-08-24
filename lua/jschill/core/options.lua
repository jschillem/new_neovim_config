local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentations
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

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

-- remove line wrapping / auto newline'
opt.textwidth = 130
opt.formatoptions = opt.formatoptions + "t" + "c"

opt.iskeyword:append("-")

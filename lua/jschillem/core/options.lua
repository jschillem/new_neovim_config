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

-- code folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldcolumn = "0"
opt.foldtext = ""
opt.foldlevel = 99
opt.foldnestmax = 4

-- for gdscript, use tabs
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "gdscript",
	callback = function()
		vim.opt.expandtab = false
	end,
})

-- godot server start
local projectfile = vim.fn.getcwd() .. "/project.godot"
if projectfile then
	vim.fn.serverstart("./godothost")
end

opt.wrap = true

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

-- -- hide command line when not in command mode
-- vim.o.cmdheight = 0
-- vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
-- 	desc = "Show command line when in command mode",
-- 	callback = function()
-- 		vim.o.cmdheight = 1
-- 	end,
-- })
-- vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
-- 	desc = "Hide command line when not in command mode",
-- 	callback = function()
-- 		vim.o.cmdheight = 0
-- 	end,
-- })

-- add not detected filetypes
vim.filetype.add({
	pattern = {
		[".?env.*"] = "sh",
	},
})

vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({ extension = { wgsl = "wgsl" } })
vim.filetype.add({ extension = { edgedb = "esdl" } })
vim.filetype.add({ extension = { roc = "roc" } })
vim.filetype.add({ extension = { postcss = "css" } })
vim.filetype.add({
	pattern = {
		[".*%.blade.php"] = "blade",
	},
})

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	callback = function()
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		if not normal.bg then
			return
		end
		io.write(string.format("\027]11;#%06x\027\\", normal.bg))
	end,
})

vim.api.nvim_create_autocmd("UILeave", {
	callback = function()
		io.write("\027]111\027\\")
	end,
})

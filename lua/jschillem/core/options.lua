vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

vim.g.have_nerd_font = true

opt.relativenumber = true
opt.number = true

opt.laststatus = 3
opt.swapfile = false

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
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
if vim.fn.filereadable(projectfile) == 1 then
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

vim.o.cmdheight = 1

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

-- Function to find Godot project root directory
local function find_godot_project_root()
	local cwd = vim.fn.getcwd()
	local search_paths = { "", "/.." }

	for _, relative_path in ipairs(search_paths) do
		local project_file = cwd .. relative_path .. "/project.godot"
		if vim.uv.fs_stat(project_file) then
			return cwd .. relative_path
		end
	end

	return nil
end

-- Function to check if server is already running
local function is_server_running(project_path)
	local server_pipe = project_path .. "/server.pipe"
	return vim.uv.fs_stat(server_pipe) ~= nil
end

-- Function to start Godot server if needed
local function start_godot_server_if_needed()
	local godot_project_path = find_godot_project_root()

	if godot_project_path and not is_server_running(godot_project_path) then
		vim.fn.serverstart(godot_project_path .. "/server.pipe")
		return true
	end

	return false
end

-- Main execution
start_godot_server_if_needed()

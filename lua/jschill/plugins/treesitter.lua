local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	highlight = {
		enable = true,
	},
	indent = { enable = true },
	autotag = { enable = true },
	ensure_installed = {
		"json",
		"c",
		"cpp",
		"rust",
		"sql",
		"lua",
		"regex",
		"python",
		"html",
		"css",
		"make",
		"gitignore",
		"glsl",
		"wgsl",
		"wgsl_bevy",
		"yaml",
		"toml",
	},
	auto_install = true,
})

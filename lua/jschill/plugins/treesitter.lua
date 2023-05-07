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
		"markdown",
		"markdown_inline",
		"c",
		"cpp",
		"rust",
		"sql",
		"javascript",
		"typescript",
		"svelte",
		"gitcommit",
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

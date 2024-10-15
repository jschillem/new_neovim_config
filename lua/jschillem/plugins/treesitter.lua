return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		---@diagnostic disable-next-line: inject-field
		parser_config.blade = {
			install_info = {
				url = "https://github.com/EmranMR/tree-sitter-blade",
				files = { "src/parser.c" },
				generate_requires_npm = true,
				requires_generate_from_grammar = true,
				branch = "main",
			},
			filetype = "blade",
		}

		treesitter.setup({
			ensure_installed = {
				"html",
				"blade",
				"css",
				"php",
				"php_only",
				"bash",
				"rust",
				"python",
				"c",
				"cpp",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<M-Space>",
					node_incremental = "<M-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}

return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	dependencies = {
		-- You may not need this if you don't lazy load
		-- Or if the parsers are in your $RUNTIMEPATH
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local presets = require("markview.presets")

		require("markview").setup({
			preview = {
				filetypes = { "markdown", "Avante" },
				icon_provider = "devicons",
			},
			markdown = {
				headings = presets.headings.glow,
			},
		})
	end,
}

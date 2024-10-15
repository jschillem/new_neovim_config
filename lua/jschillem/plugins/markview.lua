return {
	"OXY2DEV/markview.nvim",
	ft = { "markdown", "Avante" },
	dependencies = {
		-- You may not need this if you don't lazy load
		-- Or if the parsers are in your $RUNTIMEPATH
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local presets = require("markview.presets")

		require("markview").setup({
			filetypes = { "markdown", "Avante" },
			checkboxes = presets.checkboxes.nerd,
			headings = presets.headings.slanted,
		})
	end,
}

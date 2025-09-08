return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	priority = 49,
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

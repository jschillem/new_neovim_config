return {
	"rachartier/tiny-devicons-auto-colors.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	config = function()
		local theme_colors = require("kanagawa.colors").setup()
		local colors = theme_colors.palette

		require("tiny-devicons-auto-colors").setup({
			colors = colors,
		})
	end,
}

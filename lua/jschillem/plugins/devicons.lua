return {
	"rachartier/tiny-devicons-auto-colors.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"navarasu/onedark.nvim",
		-- "rebelot/kanagawa.nvim",
	},
	event = "VeryLazy",
	config = function()
		-- local theme_colors = require("kanagawa.colors").setup()
		-- local colors = theme_colors.palette

		local colors = require("onedark.palette").dark

		require("tiny-devicons-auto-colors").setup({
			colors = colors,
		})
	end,
}

return {
	"rachartier/tiny-devicons-auto-colors.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"navarasu/onedark.nvim",
		-- "rebelot/kanagawa.nvim",
	},
	event = "VeryLazy",
	config = function()
		local theme = require("onedark.palette").dark

		require("tiny-devicons-auto-colors").setup({
			colors = theme,
			cache = {
				enabled = true,
				path = vim.fn.stdpath("cache") .. "/tiny-devicons-auto-colors-cache.json",
			},
			precise_search = {
				enabled = true,
				iteration = 10, -- It goes hand in hand with 'precision'
				precision = 20, -- The higher the precision, better the search is
				threshold = 23, -- Threshold to consider a color as a match (larger is more permissive)
			},
		})
	end,
}

return {
	"brenoprata10/nvim-highlight-colors",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-highlight-colors").setup({
			render = "virtual",
			enable_tailwind = true,
			virtual_symbol = "●",
		})
	end,
}

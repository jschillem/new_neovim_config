return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	config = true,
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "open trouble diagnostics" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "open buffer trouble diagnostics" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "open trouble location list" },
	},
}

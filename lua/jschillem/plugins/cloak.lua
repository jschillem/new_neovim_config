return {
	"laytan/cloak.nvim",
	event = "VeryLazy",
	config = function()
		require("cloak").setup({})

		vim.keymap.set("n", "<leader>ct", "<cmd>CloakToggle<CR>", { desc = "Toggle cloak" })
	end,
}

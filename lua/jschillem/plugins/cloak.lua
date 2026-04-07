return {
	"laytan/cloak.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("cloak").setup({})

		vim.keymap.set("n", "<leader>ct", "<cmd>CloakToggle<CR>", { desc = "Toggle cloak" })
	end,
}

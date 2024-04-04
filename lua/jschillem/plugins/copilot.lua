return {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<M-a>",
				},
			},
		})

		vim.keymap.set("n", "<leader>ct", ":Copilot toggle<CR>", { desc = "Toggle Copilot" })
	end,
}

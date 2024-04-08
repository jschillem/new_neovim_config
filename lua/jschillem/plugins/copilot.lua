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

		-- Start disabled
		vim.cmd("Copilot disable")

		vim.keymap.set("n", "<leader>ce", ":Copilot enable<CR>", { desc = "Enable Copilot" })
		vim.keymap.set("n", "<leader>cd", ":Copilot disable<CR>", { desc = "Disable Copilot" })
	end,
}

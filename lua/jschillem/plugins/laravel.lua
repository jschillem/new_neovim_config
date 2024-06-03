return {
	"adalessa/laravel.nvim",
	cond = function()
		-- detect if composer.json is present in current directory or any parent directory up to 4 levels
		local path = vim.fn.getcwd()
		for _ = 1, 4 do
			if vim.fn.filereadable(path .. "/composer.json") == 1 then
				return true
			end
			path = vim.fn.fnamemodify(path, ":h")
		end
		return false
	end,
	config = function()
		local laravel = require("laravel")
		laravel.setup({
			lsp_server = "intelephense",
			features = {
				null_ls = {
					enable = false,
				},
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>la", ":Laravel artisan<CR>", { desc = "Laravel artisan" })
		keymap.set("n", "<leader>lr", ":Laravel routes<CR>", { desc = "Laravel routes" })
		keymap.set("n", "<leader>lm", ":Laravel related<CR>", { desc = "Laravel related" })
	end,
}

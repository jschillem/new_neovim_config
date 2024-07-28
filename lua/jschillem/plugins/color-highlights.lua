return {
	"brenoprata10/nvim-highlight-colors",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-highlight-colors").setup({
			render = "virtual",
			enable_tailwind = true,
			virtual_symbol = "■",
			exclude_filetypes = {
				"elixir",
				"rust",
				"c",
				"cpp",
			},
		})

		-- create autocommands to turnOn and turnOff the plugin when exititing and entering insert mode
		vim.api.nvim_create_augroup("nvim-highlight-colors", {
			clear = false,
		})

		vim.api.nvim_create_autocmd("InsertEnter", {
			group = "nvim-highlight-colors",
			desc = "Turn off nvim-highlight-colors when entering insert mode",
			callback = function()
				require("nvim-highlight-colors").turnOff()
			end,
		})

		vim.api.nvim_create_autocmd("InsertLeave", {
			group = "nvim-highlight-colors",
			desc = "Turn on nvim-highlight-colors when exiting insert mode",
			callback = function()
				require("nvim-highlight-colors").turnOn()
			end,
		})
	end,
}

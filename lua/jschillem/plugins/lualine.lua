return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"linrongbin16/lsp-progress.nvim",
	},
	config = function()
		-- Setup lsp-progress first
		require("lsp-progress").setup()

		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		lualine.setup({
			options = {
				theme = "tokyonight",
				color = {
					gui = "bold",
				},
				section_separators = "",
				component_separators = "",
			},
			sections = {
				lualine_c = {
					function()
						return require("lsp-progress").progress()
					end,
				},
				lualine_x = {
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})

		-- Refresh lualine when lsp-progress updates
		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("lualine_lsp_progress", { clear = true }),
			pattern = "LspProgressStatusUpdated",
			callback = function()
				lualine.refresh()
			end,
		})
	end,
}

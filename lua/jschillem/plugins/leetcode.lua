return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	cmd = "Leet",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- required by telescope
		"MunifTanjim/nui.nvim",

		-- optional
		"rcarriga/nvim-notify",
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("leetcode").setup({
			lang = "python",
		})

		local banned_messages = { "No information available" }
		vim.notify = function(msg, ...)
			for _, banned in ipairs(banned_messages) do
				if msg == banned then
					return
				end
			end
			return require("notify")(msg, ...)
		end
	end,
}

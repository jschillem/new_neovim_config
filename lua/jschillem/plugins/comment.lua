return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},

	config = function()
		local comment = require("Comment")
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		local context_integration = require("ts_context_commentstring.integrations.comment_nvim")

		comment.setup({
			pre_hook = context_integration.create_pre_hook(),
		})
	end,
}

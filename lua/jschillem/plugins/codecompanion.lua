return {
	"olimorris/codecompanion.nvim",
	version = "^19.0.0",
	keys = {
		{ "<Leader>aic", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat" },
		{ "<Leader>aia", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
		{ "<Leader>aip", "<cmd>CodeCompanion<cr>", desc = "CodeCompanion Inline Prompt" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		interactions = {
			chat = {
				adapter = "anthropic",
			},
			cli = {
				agent = "claude_code",
				agents = {
					claude_code = {
						cmd = "claude",
						args = {},
						description = "Claude Code CLI",
						provider = "terminal",
					},
				},
			},
		},
		adapters = {
			http = {
				anthropic = function()
					return require("codecompanion.adapters").extend("anthropic", {
						env = {
							api_key = "cmd:op read op://private/Anthropic/credential --no-newline",
						},
					})
				end,
			},
		},
	},
}

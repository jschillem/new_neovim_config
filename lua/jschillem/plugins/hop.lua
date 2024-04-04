return {
	"hadronized/hop.nvim",
	event = { "BufReadPre", "BufNewFile" },
	branch = "v2",
	config = function()
		local hop = require("hop")
		local directions = require("hop.hint")

		hop.setup({
			keys = "etovxqpdygfblzhckisuran",
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>j", ":HopWord<CR>", { desc = "Hop to a specific word" })
		keymap.set("n", "<leader>J", ":HopLineStart<CR>", { desc = "Hop to a specific line" })

		keymap.set("", "f", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
		end, { desc = "Hop to a character (inclusive) after the cursor", remap = true })
		keymap.set("", "F", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
		end, { desc = "Hop to a character (inclusive) before the cursor", remap = true })
		keymap.set("", "t", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
		end, { desc = "Hop to a character (exclusive) after the cursor", remap = true })
		keymap.set("", "T", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
		end, { desc = "Hop to a character (exclusive) before the cursor", remap = true })
	end,
}

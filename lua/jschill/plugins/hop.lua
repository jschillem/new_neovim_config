local status, hop = pcall(require, "hop")
if not status then
	return
end

local dir_status, directions = pcall(require, "hop.hint")
if not dir_status then
	return
end

local keymap = vim.keymap

hop.setup({
	keys = "etovxqpdygfblzhckisuran",
})

keymap.set("n", "<leader>h", ":HopWord<CR>")
keymap.set("n", "<leader>H", ":HopLineStart<CR>")

keymap.set("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
keymap.set("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
keymap.set("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
keymap.set("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

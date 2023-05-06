local status, hop = pcall(require, "hop")
if not status then
	return
end

local keymap = vim.keymap

hop.setup({
	keys = "etovxqpdygfblzhckisuran",
})

keymap.set("n", "<leader>h", ":HopWord<CR>")
keymap.set("n", "<leader>H", ":HopLineStart<CR>")

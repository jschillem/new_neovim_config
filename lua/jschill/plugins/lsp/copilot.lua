local status, copilot = pcall(require, "copilot")
if not status then
	return
end

local cmp_status, cp_cmp = pcall(require, "copilot_cmp")

copilot.setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})
cp_cmp.setup({})

-- Write it so I can toggle on/off copilot autocomplete with the <Leader>gct keybinding (copilot toggle)
vim.api.nvim_set_keymap("n", "<Leader>gct", "<cmd>Copilot toggle<CR>", { noremap = true, silent = true })

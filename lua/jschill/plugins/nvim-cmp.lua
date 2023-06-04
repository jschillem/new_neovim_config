local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

-- luaSnip keybinds/setup
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, { silent = true })

-- load friendly-snippets
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-a>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources(
		{ { name = "nvim_lsp_signature_help" } },
		{ { name = "nvim_lsp" } }, -- lsp
		{ { name = "luasnip" } }, -- snippets
		{ { name = "buffer" } }, -- text within current buffer
		{ { name = "path" } }, -- file system paths
		{ { name = "nvim_lua" } },
		{ { name = "emoji" } }
	),
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})

vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
	pattern = "Cargo.toml",
	callback = function()
		cmp.setup.buffer({ sources = { { name = "crates" } } })
	end,
})

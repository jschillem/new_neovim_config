local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		formatting.prettier.with({
			extra_filetypes = { "svelte" },
			disabled_filetypes = { "htmldjango" },
		}),
		formatting.djlint,
		formatting.stylua,
		formatting.gofmt,
		formatting.ocamlformat,
		-- formatting.clang_format,
		formatting.gdformat,
		formatting.csharpier,
		formatting.buf,
		diagnostics.buf,
	},

	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWrite", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						async = false,
					})
				end,
			})
		end
	end,
})

local notify = vim.notify
vim.notify = function(msg, ...)
	if msg:match("warning: multiple different client offset_encodings") then
		return
	end

	notify(msg, ...)
end

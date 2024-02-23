local neodev_status, neodev = pcall(require, "neodev")
if not neodev_status then
	return
end

neodev.setup({})

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local typescript_status, typescript = pcall(require, "typescript")
if not typescript_status then
	return
end

local keymap = vim.keymap

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }
	-- vim.lsp.buf.inlay_hint(bufnr, true)

	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- got to declaration
	keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader><C-d>", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts) -- show diagnostics in buffer
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	-- keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")
	end
end

local Capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig["html"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["cssls"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["prismals"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["clangd"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["jdtls"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["lemminx"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["gdscript"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["rust_analyzer"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["wgsl_analyzer"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
	filetypes = { "wgsl" },
})

lspconfig["tailwindcss"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["svelte"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

lspconfig["eslint"].setup({
	capabilities = Capabilities,
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWrite", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
	settings = {
		packageMananger = "pnpm",
	},
})

lspconfig["pylsp"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["htmx"].setup({
	capabilities = Capabilities,
	filetypes = { "html", "astro", "javascriptreact", "typescriptreact" },
	on_attach = on_attach,
})

lspconfig["omnisharp"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["gopls"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["bufls"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["ocamllsp"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["taplo"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["astro"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["sqlls"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

lspconfig["emmet_ls"].setup({
	capabilities = Capabilities,
	on_attach = on_attach,
})

typescript.setup({
	server = {
		capabilities = Capabilities,
		on_attach = on_attach,
		settings = {
			javascript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
			},
			typescript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
			},
		},
	},
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- keybind options
		local opts = { noremap = true, silent = true }

		-- set keybinds
		keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
		keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
		keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
		keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
		keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
		keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
		keymap.set("n", "<leader><C-d>", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts) -- show diagnostics in buffer
		keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
		keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
		keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
		keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
		keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
		keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
	end,
})

local swift_lsp = vim.api.nvim_create_augroup("swift_lsp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "swift" },
	callback = function()
		local root_dir = vim.fs.dirname(vim.fs.find({
			"Package.swift",
			".git",
		}, { upward = true })[1])
		local client = vim.lsp.start({
			name = "sourcekit-lsp",
			cmd = { "sourcekit-lsp" },
			root_dir = root_dir,
		})
		vim.lsp.buf_attach_client(0, client)
	end,
	group = swift_lsp,
})

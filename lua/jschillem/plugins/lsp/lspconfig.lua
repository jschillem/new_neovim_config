return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local configs = require("lspconfig.configs")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local utils = require("jschillem.utils")
		local keymap = vim.keymap

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitons"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd> Telescope diagnostics buffnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for item under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Setup for blade
		configs.blade = {
			default_config = {
				cmd = { "laravel-dev-tools", "lsp" },
				filetypes = { "blade" },
				root_dir = function(fname)
					return lspconfig.util.find_git_ancestor(fname)
				end,
				settings = {},
			},
		}

		-- Special languages
		lspconfig.blade.setup({
			capabilities = capabilities,
		})

		-- swift
		lspconfig["sourcekit"].setup({
			capabilities = capabilities,
			filetypes = { "swift", "objective-c" },
		})

		-- gleam
		lspconfig["gleam"].setup({
			capabilities = capabilities,
		})

		-- godot (gdscript)
		lspconfig["gdscript"].setup({
			capabilities = capabilities,
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["elixirls"] = function()
				lspconfig["elixirls"].setup({
					cmd = { "/bin/elixir-ls" },
				})
			end,
			["svelte"] = function()
				-- configure svelte server
				lspconfig["svelte"].setup({
					capabilities = capabilities,
					on_attach = function(client, _)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								-- Here use ctx.match instead of ctx.file
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				})
			end,
			["emmet_language_server"] = function()
				lspconfig["emmet_language_server"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"htmldjango",
						"typescriptreact",
						"javascriptreact",
						"blade",
						"php",
						"vue",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
						"astro",
						"templ",
					},
				})
			end,
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
			["intelephense"] = function()
				lspconfig["intelephense"].setup({
					capabilities = capabilities,
					settings = {
						intelephense = {
							environment = {
								includePaths = {
									"/usr/share/php/stubs",
								},
							},
						},
					},
					init_options = {
						licenceKey = utils.load_env()["INTELEPHENSE_LICENSE_KEY"],
					},
					filetypes = {
						"php",
						"blade",
						"php_only",
					},
				})
			end,
			["html"] = function()
				lspconfig["html"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"blade",
					},
				})
			end,
			["tsserver"] = function()
				lspconfig["ts_ls"].setup({
					capabilities = capabilities,
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								-- location = require("mason-registry")
								-- 	.get_package("vue-language-server")
								-- 	:get_install_path() .. "/node_modules/@vue/language-server",
								location = ".nvm/versions/node/v20.15.1/lib/node_modules/@vue/typescript-plugin",
								languages = { "vue" },
							},
						},
					},
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				})
			end,
			["volar"] = function()
				lspconfig["volar"].setup({
					capabilities = capabilities,
					on_new_config = function(new_config, new_root_dir)
						new_config.init_options.typescript.tsdk = utils.get_typescript_server_path(new_root_dir)
					end,
					-- init_options = {
					-- 	vue = {
					-- 		hybridMode = false,
					-- 	},
					-- },
				})
			end,
		})
	end,
	lspcon,
}

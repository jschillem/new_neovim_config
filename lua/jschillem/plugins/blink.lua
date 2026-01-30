return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	build = "cargo build --release",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
		"onsails/lspkind.nvim",
	},
	version = "1.*",

	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		enabled = function()
			local disable_in = { "DressingInput", "TelescopePrompt", "NvimTree", "lazy", "mason" }
			for _, ft in ipairs(disable_in) do
				if vim.bo.filetype == ft then
					return false
				end
			end

			return true
		end,
		keymap = {
			preset = "default",
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				draw = {
					components = {
						kind_icon = {
							text = function(ctx)
								local icon = ctx.kind_icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = require("lspkind").symbolic(ctx.kind)
								end

								return icon .. ctx.icon_gap
							end,
							highlight = function(ctx)
								local hl = ctx.kind_hl
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										hl = dev_hl
									end
								end

								return hl
							end,
						},
					},
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				treesitter_highlighting = true,
				window = {
					border = "single",
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				snippets = {
					min_keyword_length = 2,
				},
				buffer = {
					min_keyword_length = 2,
				},
			},
		},
		snippets = {
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet() or false
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},
		signature = {
			enabled = true,
			window = {
				border = "single",
			},
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	},
	config = function(_, opts)
		-- Setup blink.cmp
		require("blink.cmp").setup(opts)

		require("luasnip.loaders.from_vscode").lazy_load()

		vim.keymap.set({ "i", "s" }, "<C-L>", function()
			require("luasnip").jump(1)
		end, { desc = "Advance in snippet" })

		vim.keymap.set({ "i", "s" }, "<C-H>", function()
			require("luasnip").jump(-1)
		end, { desc = "Go back in snippet" })

		vim.keymap.set({ "i", "s" }, "<C-E>", function()
			require("luasnip").change_choice(1)
		end, { desc = "Change the active snippet choice" })
	end,
	opts_extend = { "sources.default" },
}

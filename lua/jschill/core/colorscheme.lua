-- local status, _ = pcall(vim.cmd, "colorscheme onedark_vivid")
-- if not status then
-- 	print("Colorscheme not found!")
-- 	return
-- end

local status, kanagawa = pcall(require, "kanagawa")
if not status then
	return
end

kanagawa.setup({
	compile = true,
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},

	overrides = function(colors)
		local theme = colors.theme
		return {
			TelescopeTitle = { fg = theme.ui.special, bold = true },
			TelescopePromptNormal = { bg = theme.ui.bg_p1 },
			TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
			TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
			TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
			TelescopePreviewNormal = { bg = theme.ui.bg_dim },
			TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
			-- NormalFloat = { bg = "none" },
			-- FloatBorder = { bg = "none" },
			-- FloatTitle = { bg = "none" },

			-- Save an hlgroup with dark background and dimmed foreground
			-- so that you can use it where your still want darker windows.
			-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

			-- Popular plugins that open floats will link to NormalFloat by default;
			-- set their background accordingly if you wish to keep them dark and borderless
			LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
			MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

			Pmenu = { fg = theme.ui.bg_dim, bg = theme.ui.bg_m1, blend = vim.o.pumblend }, -- add `` to enable transparency
			PmenuSel = { fg = "NONE", bg = theme.ui.bg_p1 },
			PmenuSbar = { bg = theme.ui.bg_p1 },
			PmenuThumb = { bg = theme.ui.bg_dim },
		}
	end,
})

local cs_status, _ = pcall(vim.cmd, "colorscheme kanagawa")
if not status then
	print("No colorscheme found!")
	return
end

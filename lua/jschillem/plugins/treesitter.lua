local languages = {
	"bash",
	"blade",
	"c",
	"cpp",
	"css",
	"gdscript",
	"gdshader",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"git_rebase",
	"html",
	"lua",
	"markdown",
	"php",
	"php_only",
	"python",
	"rust",
	"toml",
	"yaml",
	"zsh",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	dependencies = { "OXY2DEV/markview.nvim" },
	config = function()
		require("nvim-treesitter").install(languages)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter.setup", {}),
			callback = function(args)
				local buf = args.buf
				local filetype = args.match

				local language = vim.treesitter.language.get_lang(filetype) or filetype
				if not vim.treesitter.language.add(language) then
					return
				end

				vim.wo.foldmethod = "expr"
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

				vim.treesitter.start(buf, language)

				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		local selection_stack = {}

		local function select_range(srow, scol, erow, ecol)
			vim.fn.setpos("'<", { 0, srow + 1, scol + 1, 0 })
			vim.fn.setpos("'>", { 0, erow + 1, ecol, 0 })
			vim.cmd("normal! gv")
		end

		vim.keymap.set("n", "<M-Space>", function()
			local node = vim.treesitter.get_node()
			if not node then
				return
			end
			selection_stack = { node }
			local srow, scol, erow, ecol = node:range()
			select_range(srow, scol, erow, ecol)
		end, { desc = "TS init selection" })

		vim.keymap.set("x", "<M-Space>", function()
			local node = selection_stack[#selection_stack]
			if not node then
				node = vim.treesitter.get_node()
				if not node then
					return
				end
				selection_stack = { node }
			end
			local csrow, cscol, cerow, cecol = node:range()
			local parent = node:parent()
			while parent do
				local psrow, pscol, perow, pecol = parent:range()
				if psrow ~= csrow or pscol ~= cscol or perow ~= cerow or pecol ~= cecol then
					break
				end
				parent = parent:parent()
			end
			if not parent then
				select_range(csrow, cscol, cerow, cecol)
				return
			end
			table.insert(selection_stack, parent)
			local srow, scol, erow, ecol = parent:range()
			select_range(srow, scol, erow, ecol)
		end, { desc = "TS node incremental" })

		vim.keymap.set("x", "<BS>", function()
			if #selection_stack <= 1 then
				return
			end

			table.remove(selection_stack)
			local node = selection_stack[#selection_stack]
			local srow, scol, erow, ecol = node:range()
			select_range(srow, scol, erow, ecol)
		end, { desc = "TS node decremental" })
	end,
}

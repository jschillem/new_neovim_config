local status, guard = pcall(require, "guard")
if not status then
	return
end

local ft_status, ft = pcall(require, "guard.filetype")
if not ft_status then
	return
end

local lint_status, g_lint = pcall(require, "guard.lint")
if not lint_status then
	return
end

ft("c,cpp"):fmt("clang-format"):lint("clang-tidy")

ft("rust"):fmt("rustfmt")

ft("go"):fmt("gofmt")

ft("typescript,javascript,typescriptreact,javascriptreact,svelte,vue"):fmt("prettier"):lint({
	cmd = "eslint",
	args = { "-f", "json", "--stdin", "--stdin-filename" },
	stdin = true,
	fname = true,
	parse = g_lint.from_json({}),
})

ft("python"):fmt("black")

ft("lua"):fmt("stylua")

ft("html,markdown,json,graphql,css,sass,postcss"):fmt("prettier")

guard.setup({
	fmt_on_save = true,
	lsp_as_default_formatter = true,
})

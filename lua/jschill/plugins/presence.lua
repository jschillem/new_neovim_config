local status, presence = pcall(require, "presence")
if not status then
	return
end

presence.setup({
	neovim_image_text = "Neovim",
	show_time = false,
})

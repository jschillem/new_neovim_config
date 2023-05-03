local dashboard_status, dashboard = pcall(require, "dashboard")
if not dashboard_status then
	return
end

local my_header = {
	" ██████╗      ██╗███████╗ ██████╗██╗  ██╗██╗██╗     ██╗     ",
	"██╔═══██╗     ██║██╔════╝██╔════╝██║  ██║██║██║     ██║     ",
	"██║██╗██║     ██║███████╗██║     ███████║██║██║     ██║     ",
	"██║██║██║██   ██║╚════██║██║     ██╔══██║██║██║     ██║     ",
	"╚█║████╔╝╚█████╔╝███████║╚██████╗██║  ██║██║███████╗███████╗",
	" ╚╝╚═══╝  ╚════╝ ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝",
	"                                                            ",
}

dashboard.setup({
	theme = "hyper",
	disable_move = true,
	config = {
		header = my_header,
		footer = { " ", "Confusion is part of programming. ― Felienne Hermans" },
	},
})

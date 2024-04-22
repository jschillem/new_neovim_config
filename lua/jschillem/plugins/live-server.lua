return {
	"barrett-ruth/live-server.nvim",
	build = "npm add -g live-server",
	cmd = { "LiveServerStart", "LiveServerStop" },
	opts = {
		args = {
			"--port=7000",
			"--browser=brave",
		},
	},
}

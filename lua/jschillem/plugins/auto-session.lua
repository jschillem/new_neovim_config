return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = {"~/", "~/code/", "~/Downloads", "~/Documents", "~/Desktop/"}
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for CWD" })
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>",{ desc = "Restore session for CWD" })

  end,
}

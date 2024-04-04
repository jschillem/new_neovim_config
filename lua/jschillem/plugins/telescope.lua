return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
           i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
           },
        },
      },
    })

    telescope.load_extension("fzf")

    -- keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in CWD" })
    keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<cr>", { desc = "Fuzzy find files in git repository" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find string in CWD" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Fuzzy find help tags" })
    keymap.set("n", "<leader>ft", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Fuzzy find LSP symbols in current buffer" })
    keymap.set("n", "/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Fuzzy find words in current buffer" })

  end,
}

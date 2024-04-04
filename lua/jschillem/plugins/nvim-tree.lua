return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree docs
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
        dotfiles = true,
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

  end
}

vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- general keymaps

   -- clear highlights
   keymap.set("n", "<leader>nh", ":nohl<CR>")

   -- cause x not to save to clipbaord
   keymap.set("n", "x", '"_x')

   -- increment/decrement
   keymap.set("n", "<leader>+", "<C-a>")
   keymap.set("n", "<leader>-", "<C-x>")

   -- window splitting
   keymap.set("n", "<leader>sv", "<C-w>v")
   keymap.set("n", "<leader>sh", "<C-w>s")
   keymap.set("n", "<leader>se", "<C-w>=")
   keymap.set("n", "<leader>sx", ":close<CR>")

   -- tabs
   keymap.set("n", "<leader>to", ":tabnew<CR>")
   keymap.set("n", "<leader>tx", ":tabclose<CR>")
   keymap.set("n", "<leader>tn", ":tabn<CR>")
   keymap.set("n", "<leader>tp", ":tabp<CR>")

-- plugin keymaps

   -- vim-maximizer
   keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

   -- nvim-tree
   keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

   -- telescope
   keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
   keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
   keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
   keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
   keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

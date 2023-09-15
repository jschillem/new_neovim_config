local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- "folke/tokyonight.nvim",
	{
		"olimorris/onedarkpro.nvim",
		lazy = true,
		priority = 900,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
	},
	-- lua functions that many plugins use
	{ "nvim-lua/plenary.nvim", lazy = false },
	-- tmux & split window navigation
	"christoomey/vim-tmux-navigator",
	"szw/vim-maximizer", -- maximizes and restores current window
	-- essential plugins
	"tpope/vim-surround",
	"vim-scripts/ReplaceWithRegister",
	-- commenting with gc
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	-- file explorer
	{ "nvim-tree/nvim-tree.lua", lazy = false },
	-- vs-code icons
	"kyazdani42/nvim-web-devicons",
	-- statusline
	"nvim-lualine/lualine.nvim",
	-- fuzzy finding
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		tag = "0.1.2",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- autocompletion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-emoji",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-path",
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",
	-- managing and installing lsp servers
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	-- configuring lsp servers
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	{ "glepnir/lspsaga.nvim", branch = "main" },
	"jose-elias-alvarez/typescript.nvim",
	"onsails/lspkind.nvim",
	-- formatting & lintingsetp
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",
	-- treesitter for better syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
	},
	-- auto closing
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",
	-- git signs plugin
	"lewis6991/gitsigns.nvim",
	-- dashboard
	{
		"glepnir/dashboard-nvim",
		lazy = false,
		priority = 950,
		event = "VimEnter",
	},
	-- indent lines
	"lukas-reineke/indent-blankline.nvim",
	-- Hop for easier navigation
	{
		"phaazon/hop.nvim",
		branch = "v2",
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("crates").setup()
		end,
	},
	"fladson/vim-kitty",
	{
		"HiPhish/nvim-ts-rainbow2",
		dependencies = { { "nvim-treesitter/nvim-treesitter" } },
	},
	{ "rcarriga/nvim-notify", lazy = false },
	{ "folke/neodev.nvim", opts = {} },
}

local opts = {}

require("lazy").setup(plugins, opts)

-- Hello world
-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- Config for startify
vim.cmd([[
  let g:startify_session_persistence = 1
]])

vim.cmd([[
  let g:startify_lists = [ { 'type': 'dir',       'header': ['   Recent files'] }, { 'type': 'sessions',  'header': ['   Saved sessions'] }, ]
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup({
	function(use)
		-- packer can manage itself
		use({
			"wbthomason/packer.nvim",
		})

		use("dstein64/vim-startuptime")

		-- Check start up time
		use("lewis6991/impatient.nvim")

		-- theme
		use("navarasu/onedark.nvim")

		use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

		use({
			"akinsho/toggleterm.nvim",
			tag = "*",
			open_mapping = [[<c-\>]],
		})

		-- Tmux
		-- use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

		use({ "szw/vim-maximizer", event = "VimEnter" }) -- maximizes and restores current window

		-- essential plugins
		use({ "tpope/vim-surround", event = "VimEnter" }) -- add, delete, change surroundings (it's awesome)
		-- use("inkarkat/vim-Re1laceWithRegister") -- replace with register contents using motion (gr + motion)

		-- commenting with gc
		use({ "numToStr/Comment.nvim" })

		-- file explorer
		use({ "nvim-tree/nvim-tree.lua" })

		-- repleat plugin command
		use({ "tpope/vim-repeat", event = "VimEnter" })
		-- vs-code like icons
		use("nvim-tree/nvim-web-devicons")

		-- statusline
		use("nvim-lualine/lualine.nvim")

		-- start
		use("mhinz/vim-startify")
		use("echasnovski/mini.nvim")
		use("rcarriga/nvim-notify")

		use({
			"karb94/neoscroll.nvim",
			config = function()
				require("liam.plugins.neoscroll")
			end,
		})

		-- fuzzy finding w/ telescope
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
		use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

		-- CMP
		use({
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			after = "friendly-snippets",
			config = function()
				require("liam.plugins.nvim-cmp")
			end,
		})

		----[[   ]]} -- completion plugin
		use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" }) -- source for text in buffer
		use({ "hrsh7th/cmp-path", after = "nvim-cmp" }) -- source for file system paths
		use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" }) -- source for file system paths
		use({ "f3fora/cmp-spell", after = "nvim-cmp" }) -- source for file system paths

		-- snippets
		use("L3MON4D3/LuaSnip") -- snippet engine
		use("saadparwaiz1/cmp_luasnip") -- for autocompletion
		use({ "rafamadriz/friendly-snippets", event = "InsertEnter" }) -- useful snippets
		use({ "mattn/emmet-vim", after = "nvim-cmp" })

		-- managing & installing lsp servers, linters & formatters
		use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
		use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

		-- configuring lsp servers
		use("neovim/nvim-lspconfig") -- easily configure language servers
		use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
		use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
		use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
		use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

		use({
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup()
			end,
		})

		-- lsp plugins
		use({
			"simrat39/symbols-outline.nvim",
			config = function()
				require("symbols-outline").setup()
			end,
		})

		use({
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup()
			end,
		})

		-- Trouble
		use({
			"folke/trouble.nvim",
			requires = "nvim-tree/nvim-web-devicons",
			config = function()
				require("trouble").setup({})
			end,
		})

		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})

		-- Testing
		use({
			"nvim-neotest/neotest",
			event = "VimEnter",
			config = function()
				require("liam.plugins.neotest")
			end,
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"antoinemadec/FixCursorHold.nvim",
				"jfpedroza/neotest-elixir",
			},
		})

		-- Visual mutli line
		use({ "mg979/vim-visual-multi", event = "VimEnter" })
		use("RRethy/vim-illuminate")

		-- elixir
		use({ "mhanberg/elixir.nvim", requires = { "nvim-lua/plenary.nvim" } })
		use("mhinz/vim-mix-format")

		-- formatting & linting
		use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
		use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

		use({
			"github/copilot.vim",
			config = function()
				require("liam.plugins.copilot")
			end,
			event = "InsertEnter",
		})

		-- wilder fuzzy find command
		-- use("gelguy/wilder.nvim")

		-- Packer
		use({
			"folke/noice.nvim",
			config = function()
				require("liam.plugins.noice")
			end,
			requires = {
				-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
				"MunifTanjim/nui.nvim",
				-- OPTIONAL:
				--   `nvim-notify` is only needed, if you want to use the notification view.
				--   If not available, we use `mini` as the fallback
				"rcarriga/nvim-notify",
				"hrsh7th/nvim-cmp",
			},
		})
		-- treesitter configuration
		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
				ts_update()
			end,
		})
		-- use("nvim-treesitter/nvim-treesitter-textobjects")
		use("nvim-treesitter/nvim-treesitter-context")

		use("RRethy/nvim-treesitter-textsubjects")
		-- aut closin(g
		use({ "windwp/nvim-autopairs" }) -- autoclose parens, brackets, quotes, etc...
		use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

		-- git integration
		use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

		-- word navigation

		use({
			"ggandor/leap.nvim",
			config = function()
				require("leap").add_default_mappings()
				-- The below settings make Leap's highlighting a bit closer to what you've been
				-- used to in Lightspeed.
				vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
				vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "red", bold = true, nocombine = true })
				vim.api.nvim_set_hl(0, "LeapLabelSecondary", { fg = "blue", bold = true, nocombine = true })
				vim.api.nvim_set_hl(0, "LeapMatch", {
					fg = "white", -- for light themes, set to 'black' or similar
					bold = true,
					nocombine = true,
				})
				-- keep old 'x' behaviour in visual mode
				vim.keymap.del({ "x", "o" }, "x")
				vim.keymap.del({ "x", "o" }, "X")
				require("leap").opts.highlight_unlabeled_phase_one_targets = true
			end,
		})

		use({
			"sudormrfbin/cheatsheet.nvim",
			requires = {
				{ "nvim-telescope/telescope.nvim" },
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
			},
		})

		-- indent line
		-- use("lukas-reineke/indent-blankline.nvim")

		-- change ui
		use({ "stevearc/dressing.nvim" })

		-- keymap
		use({
			"folke/which-key.nvim",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
			end,
		})

		use("mrjones2014/legendary.nvim")

		-- Lazy git
		use("kdheepak/lazygit.nvim")

		-- spectire find and replace
		use("windwp/nvim-spectre")

		-- harpoon
		use("ThePrimeagen/harpoon")

		-- Taking notes
		use({
			"renerocksai/telekasten.nvim",
			disable = true,
		})

		use({
			event = "CmdlineEnter",
			"nvim-neorg/neorg",
			config = function()
				require("liam.plugins.neorg")
			end,
		})
		use({ "nvim-neorg/neorg-telescope" })

		use({ "michaelb/sniprun", run = "bash ./install.sh" })
		use("akinsho/org-bullets.nvim")
		use("lukas-reineke/headlines.nvim")

		-- zen mode
		use({ "folke/zen-mode.nvim", event = "CmdlineEnter" })
		use({ "shortcuts/no-neck-pain.nvim", event = "CmdlineEnter" })

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		max_jobs = 10,
	},
})

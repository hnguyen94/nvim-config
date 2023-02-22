local Hydra = require("hydra")

local cmd = require("hydra.keymap-util").cmd
Hydra({
	name = "Side scroll",
	mode = "n",
	body = "z",
	heads = {
		{ "h", "5zh" },
		{ "l", "5zl", { desc = "←/→" } },
		{ "H", "zH" },
		{ "L", "zL", { desc = "half screen ←/→" } },
	},
})

Hydra({
	name = "Moving windows",
	mode = "n",
	config = {
		hint = false,
	},
	body = "<C-w>",
	heads = {
		-- move between windows
		{ "h", "<C-w>h" },
		{ "l", "<C-w>l" },
		{ "j", "<C-w>j" },
		{ "k", "<C-w>k" },

		-- resizing window
		{ "H", "<C-w>3<" },
		{ "L", "<C-w>3>" },
		{ "K", "<C-w>2+" },
		{ "J", "<C-w>2-" },

		-- equalize
		{ "=", "<C-w>=" },

		-- exit this Hydra
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})

Hydra({
	name = "Harpoon moving",
	mode = "n",
	body = "<leader>h",
	heads = {
		{ "[", cmd("lua require('harpoon.ui').nav_next()"), { desc = "Harpoon next" } },
		{ "]", cmd("lua require('harpoon.ui').nav_prev()"), { desc = "Harpoon prev" } },
		{ "]", cmd("lua require('harpoon.ui').nav_prev()") },
	},
})
local hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _s_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐
  ██🬿      🭊██   _r_: resume      
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: execute command
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymaps     _;_: commands history
                 _O_: options     _?_: search history
 ^
                 _<Enter>_: Telescope           _<Esc>_
]]

Hydra({
	name = "Telescope",
	hint = hint,
	config = {
		color = "teal",
		invoke_on_body = true,
		hint = {
			position = "middle",
			border = "rounded",
		},
	},
	mode = "n",
	body = "<Leader>f",
	heads = {
		{ "f", cmd("Telescope find_files") },
		{ "s", cmd("Telescope live_grep") },
		{ "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
		{ "h", cmd("Telescope help_tags"), { desc = "vim help" } },
		{ "m", cmd("MarksListBuf"), { desc = "marks" } },
		{ "k", cmd("Telescope keymaps") },
		{ "O", cmd("Telescope vim_options") },
		{ "r", cmd("Telescope resume") },
		{ "p", cmd("Telescope projects"), { desc = "projects" } },
		{ "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
		{ "?", cmd("Telescope search_history"), { desc = "search history" } },
		{ ";", cmd("Telescope command_history"), { desc = "command-line history" } },
		{ "c", cmd("Telescope commands"), { desc = "execute command" } },
		{ "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})

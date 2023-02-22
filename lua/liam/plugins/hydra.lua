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
	},
})

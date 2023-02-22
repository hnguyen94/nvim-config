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

local hint = [[
 _]_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _[_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _<Esc>_: exit
]]

local gitsigns = require("gitsigns")

Hydra({
	name = "Git",
	hint = hint,
	config = {
		buffer = bufnr,
		color = "pink",
		invoke_on_body = true,
		hint = {
			border = "rounded",
		},
		on_enter = function()
			vim.cmd("mkview")
			vim.cmd("silent! %foldopen!")
			vim.bo.modifiable = false
			-- gitsigns.toggle_linehl(true)
		end,
		on_exit = function()
			local cursor_pos = vim.api.nvim_win_get_cursor(0)
			vim.cmd("loadview")
			vim.api.nvim_win_set_cursor(0, cursor_pos)
			vim.cmd("normal zv")
			-- gitsigns.toggle_linehl(false)
			gitsigns.toggle_deleted(false)
		end,
	},
	mode = { "n", "x" },
	body = "<leader>g",
	heads = {
		{
			"]",
			function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gitsigns.next_hunk()
				end)
				return "<Ignore>"
			end,
			{ expr = true, desc = "next hunk" },
		},
		{
			"[",
			function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gitsigns.prev_hunk()
				end)
				return "<Ignore>"
			end,
			{ expr = true, desc = "prev hunk" },
		},
		{ "s", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
		{ "u", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
		{ "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
		{ "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
		{ "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
		{ "b", gitsigns.blame_line, { desc = "blame" } },
		{
			"B",
			function()
				gitsigns.blame_line({ full = true })
			end,
			{ desc = "blame show full" },
		},
		{ "/", gitsigns.show, { exit = true, desc = "show base file" } }, -- show the base of the file
		{ "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
		{ "<Esc>", nil, { exit = true, nowait = true, desc = "exit" } },
	},
})

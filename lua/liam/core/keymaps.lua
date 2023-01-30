vim.g.mapleader = " "

local keymap = vim.keymap
-- Core keymaps
keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

local status, legendary = pcall(require, "legendary")
if not status then
	return
end

legendary.setup({
	keymaps = {
		-- Legendary
		{ "<leader>/", ":Legendary<cr>", description = "Open Legendary panep" },
		{
			itemgroup = "Tab management",
			keymaps = {
				{ "<leader>tn", ":tabnew<CR>", description = "Open new tab" },
				{ "<leader>tx", ":tabclose<CR>", description = "Close current tab" },
				{ "<leader>t]", ":tabn<CR>", description = "Go to next tab" },
				{ "<leader>t[", ":tabp<CR>", description = "Go to previous tab" },
			},
		},

		-- Terminal
		{ "<leader>tt", ":ToggleTerm direction=tab<CR>", description = "Open terminal in new tab" },
		{ "<leader>tf", ":ToggleTerm direction=float<CR>", description = "Open terminal in float" },

		-- Window management
		{ "<C-w>m", ":MaximizerToggle<cr>", description = "Maximize current window" },
		{ "<leader>w", ":close<cr>", description = "Close window" },

		-- Nerd tree
		{ "<leader>0", ":NvimTreeToggle<CR>", description = "Toggle Nerdtree" },
		{ "<leader>J", ":NvimTreeFindFile<cr>", description = "Highlight current file in Nerdtree" },

		{
			itemgroup = "Telescope",
			keymaps = {
				{ "<leader>ff", ":Telescope find_files<cr>", description = "Find files" },
				{ "<leader>fs", ":Telescope live_grep<cr>", description = "Find string in current working directory" },
				{
					"<leader>fc",
					":Telescope grep_string<cr>",
					description = "Find string under cursor in current working directory",
				},
				{ "<leader>fb", ":Telescope buffers<cr>", description = "List open buffers in currrent instance" },
				{ "<leader>fh", ":Telescope help_tags<cr>", description = "List available help tags" },
				{ "<leader>fp", ":Telescope builtin<cr>", description = "List built in fuctions" },
				{ "<leader>fo", ":lua require'telescope.builtin'.oldfiles{}<cr>", description = "List old files" },

				-- Telescope git
				{ "<leader>gc", ":Telescope git_commits<cr>", description = "List git commits" },
				{ "<leader>gfc", ":Telescope git_bcommits<cr>", description = "List git commits for current file" },
				{ "<leader>gb", ":Telescope git_branches<cr>", description = "List git branches" },
				{ "<leader>gs", ":Telescope git_status<cr>", description = "List current changes with diff preview" }, -- might not needed
			},
		},

		{
			itemgroup = "Startify",
			keymaps = {
				{ "<leader>Sl", ":SLoad<cr>", description = "Load session" },
				{ "<leader>Sw", ":SSave<cr>", description = "Save session" },
				{ "<leader>Sd", ":SDelete<cr>", description = "Delete session" },
				{ "<leader>Sq", ":SClose<cr>", description = "Close session" },
			},
		},

		{
			itemgroup = "Spectre",
			description = "Spectre is tool to find and replace string in working directory",
			keymaps = {
				{ "<leader>sr", ":Spectre<CR>", description = "Find and replace" },
				{
					"<leader>sw",
					"<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
					description = "Find selected word",
				},
				{
					"<leader>sf",
					":lua require('spectre').open_file_search()<cr>",
					description = "Find and replace in file",
				},
			},
		},

		{
			itemgroup = "Telekasten",
			description = "Telekasten is a quick note tool",
			keymaps = {
				{ "<leader>zp", ":lua require('telekasten').panel()<cr>", description = "Open Telekasten panel" },
				{ "<leader>zf", ":lua require('telekasten').find_notes()<cr>", description = "Find notes" },
				{ "<leader>zd", ":lua require('telekasten').find_daily_notes()<cr>", description = "Find daily notes" },
				{
					"<leader>zg",
					":lua require('telekasten').search_notes()<cr>",
					description = "Search string in notes",
				},
				{
					"<leader>zz",
					"<cmd>lua require('telekasten').follow_link()<cr>",
					description = "Follow link in notes",
				},
			},
		},

		-- Lazy git
		{ "<leader>lg", ":LazyGit<CR>", description = "Open Lazy Git" },

		-- LSP
		{
			itemgroup = "LSP",
			keymaps = {

				{ "gf", ":Lspsaga lsp_finder<CR>", description = "Show definition and references" },
				{ "gd", ":Lspsaga peek_definition<CR>", description = "Peek definition and make edits in window" },
				{ "gi", ":lua vim.lsp.buf.implementation()<CR>", description = "Go to implementation" },
				{ "<leader>ca", ":Lspsaga code_action<CR>", description = "Run code action" },
				{ "<leader>rn", ":Lspsaga rename<CR>", description = "Smart rename action" },
				{ "<leader>D", ":Lspsaga show_line_diagnostics<CR>", description = "Show line diagnostics" },
				{ "<leader>d", ":Lspsaga show_cursor_diagnostics<CR>", description = "Show cursor diagnostics" },
				{ "[d", ":Lspsaga diagnostic_jump_prev<CR>", description = "Jump to previous diagnostic" },
				{ "]d", ":Lspsaga diagnostic_jump_next<CR>", description = "Jump to next diagnostic" },
				{ "gI", ":Lspsaga hover_doc<CR>", description = "Show documentation under cursor" },
			},
		},
	},
})

-- keymap.set("n", "gI", "<cmd>", opts) -- show documentation for what is under cursor

-- terminal
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

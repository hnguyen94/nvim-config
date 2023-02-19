vim.g.mapleader = " "

local keymap = vim.keymap
-- Core keymaps
keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")

keymap.set("i", "<C-b>", "<C-Left>")
keymap.set("i", "<C-f>", "<C-Right>")

-- Emmet change leader key
vim.g.user_emmet_leader_key = "<C-z>"

local status, legendary = pcall(require, "legendary")
if not status then
	return
end

legendary.setup({
	keymaps = {
		-- Legendary
		{ "<leader>/", ":Legendary<cr>", description = "Open Legendary panep" },
		{ ",a", "ggVG", description = "Select all" },
		{
			"<leader>bd",
			":%bd|e#|bd#<cr>|'\"",
			description = "Remove all buffers and jump back to my original cursor position.",
		},
		{
			itemgroup = "Tab management",
			keymaps = {
				{ ",tn", ":tabnew<CR>", description = "Open new tab" },
				{ ",tx", ":tabclose<CR>", description = "Close current tab" },
				{ ",t]", ":tabn<CR>", description = "Go to next tab" },
				{ ",t[", ":tabp<CR>", description = "Go to previous tab" },
			},
		},

		-- Terminal
		{ "<leader>tt", ":ToggleTerm direction=tab<CR>", description = "Open terminal in new tab" },
		{ "<leader>tf", ":ToggleTerm direction=float<CR>", description = "Open terminal in float" },

		-- Window management
		{ "<C-w>m", ":MaximizerToggle<cr>", description = "Maximize current window" },
		{ ",w", ":close<cr>", description = "Close window" },

		-- Nerd tree
		{ "<leader>0", ":NvimTreeToggle<CR>", description = "Toggle Nerdtree" },
		{ "<leader>)", ":NvimTreeFocus<CR>", description = "Focus Nerdtree" },
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
				{ ",fr", ":Spectre<CR>", description = "Find and replace" },
				{
					",fw",
					"<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
					description = "Find selected word",
				},
				{
					",ff",
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

		-- Github Copilot
		{
			"<C-Tab>",
			{ i = "<esc>:Copilot panel<CR>" },
			description = "Open Github Copilot panel",
		},

		-- LSP
		{
			itemgroup = "LSP",
			keymaps = {

				{ "gR", ":Lspsaga lsp_finder<CR>", description = "Show definition and references" },
				{ "gd", ":Lspsaga peek_definition<CR>", description = "Peek definition and make edits in window" },
				{ "gD", ":Lspsaga goto_definition<CR>", description = "Go to definition" },
				{ "gi", ":lua vim.lsp.buf.implementation()<CR>", description = "Go to implementation" },
				{ "<leader>ca", ":Lspsaga code_action<CR>", description = "Run code action" },
				{ "grn", ":Lspsaga rename<CR>", description = "Smart rename action" },
				{ "<leader>D", ":Lspsaga show_line_diagnostics<CR>", description = "Show line diagnostics" },
				{ "<leader>d", ":Lspsaga show_cursor_diagnostics<CR>", description = "Show cursor diagnostics" },
				{ "[d", ":Lspsaga diagnostic_jump_prev<CR>", description = "Jump to previous diagnostic" },
				{ "]d", ":Lspsaga diagnostic_jump_next<CR>", description = "Jump to next diagnostic" },
				{ "gI", ":Lspsaga hover_doc<CR>", description = "Show documentation under cursor" },
				{ "<C-s>", ":SymbolsOutline<CR>", description = "Toggle Symbols Outline" },
			},
		},

		-- Harpoon
		{
			itemgroup = "Harpoon",
			keymaps = {

				{ "<leader>ha", ":lua require('harpoon.mark').add_file()<cr>", description = "Add file to harpoon" },
				{
					"<leader>ht",
					":lua require('harpoon.ui').toggle_quick_menu()<cr>",
					description = "Toggle Harpoon menu",
				},
				{ "<leader>h]", ":lua require('harpoon.ui').nav_next()<cr>", description = "Navigate next" },
				{ "<leader>h[", ":lua require('harpoon.ui').nav_previous()<cr>", description = "Navigate previous" },
			},
		},

		-- Neotest
		{
			itemgroup = "Neotest",
			keymaps = {
				{ "<leader>tr", ":lua require('neotest').run.run()<cr>", description = "Run nearest test" },
				{ "<leader>tl", ":lua require('neotest').run.run_last()<cr>", description = "Run last test" },
				{ "<leader>tx", ":lua require('neotest').run.stop()<cr>", description = "Stop testing" },
				{ "<leader>to", ":lua require('neotest').output.open()<cr>", description = "Output" },
				{
					"<leader>tO",
					":lua require('neotest').output_panel.toggle()<cr>",
					description = " Test Output panel",
				},
				{ "<leader>ts", ":lua require('neotest').summary.toggle()<cr>", description = "Test Summary" },
				-- { "<leader>Td", ":h neotest.diagnostic<cr>", description = "Test diagnostic" },
				-- { "<leader>Ts", ":h neotest.status<cr>", description = "Test status sign" },
				{
					"<leader>tf",
					":lua require('neotest').run.run(vim.fn.expand('%')) <cr>",
					description = "Run current file",
				},
			},
		},
	},
})

-- terminal
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<C-v>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

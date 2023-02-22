vim.g.mapleader = " "

local keymap = vim.keymap
-- Core keymaps
keymap.set("n", "<leader>nh", ":silent! nohl<CR>")
keymap.set("n", "q:", "<nop>", { noremap = true })

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

local silent_opts = { silent = true }

legendary.setup({
	keymaps = {
		-- Legendary
		{ "<leader>/", ":Legendary<cr>", description = "Open Legendary panep", opts = silent_opts },
		{ ",a", "ggVG", description = "Select all" },
		{
			"<leader><Enter>",
			":call append(line('.'), '')<cr>",
			description = "Insert new line and stay in Normal mode",
			opts = silent_opts,
		},
		{
			"<leader><S-Enter>",
			":call append(line('.')-1, '')<cr>",
			description = "Insert above new line and stay in Normal mode",
			opts = silent_opts,
		},
		{
			"<leader>bd",
			":%bd|e#|bd#<cr>|'\"",
			description = "Remove all buffers and jump back to my original cursor position.",
		},
		{
			itemgroup = "Tab management",
			keymaps = {
				{ ",tn", ":tabnew<CR>", description = "Open new tab", opts = silent_opts },
				{ ",tx", ":tabclose<CR>", description = "Close current tab", opts = silent_opts },
				{ ",t]", ":tabn<CR>", description = "Go to next tab", opts = silent_opts },
				{ ",t[", ":tabp<CR>", description = "Go to previous tab", opts = silent_opts },
			},
		},

		-- Terminal
		{
			"<leader>Tt",
			":ToggleTerm direction=tab<CR>",
			description = "Open terminal in new tab",
			opts = silent_opts,
		},
		{
			"<leader>Tf",
			":ToggleTerm direction=float<CR>",
			description = "Open terminal in float",
			opts = silent_opts,
		},

		-- Window management
		{ "<C-w>m", ":MaximizerToggle<cr>", description = "Maximize current window", opts = silent_opts },
		{ ",w", ":close<cr>", description = "Close window", opts = silent_opts },

		-- Nerd tree
		{ "<leader>0", ":NvimTreeToggle<CR>", description = "Toggle Nerdtree", opts = { silent = true } },
		{ "<leader>1", ":NvimTreeFindFile<CR>", description = "Find file in Nerdtree", opts = { silent = true } },
		{ "<leader>)", ":NvimTreeFocus<CR>", description = "Focus Nerdtree", opts = { silent = true } },
		{
			"<leader>J",
			":NvimTreeFindFile<cr>",
			description = "Highlight current file in Nerdtree",
			opts = { silent = true },
		},

		-- Notification
		{
			",h",
			":lua require('notify').dismiss()<cr>",
			description = "Dismiss current notifications",
			opts = silent_opts,
		},

		{
			itemgroup = "Telescope",
			keymaps = {
				{ "<leader>ff", ":Telescope find_files<cr>", description = "Find files", opts = silent_opts },
				{
					"<leader>fs",
					":Telescope live_grep<cr>",
					description = "Find string in current working directory",
					opts = silent_opts,
				},
				{
					"<leader>fc",
					":Telescope grep_string<cr>",
					description = "Find string under cursor in current working directory",
					opts = silent_opts,
				},
				{
					"<leader>fb",
					":Telescope buffers<cr>",
					description = "List open buffers in currrent instance",
					opts = silent_opts,
				},
				{ "<leader>fp", ":Telescope builtin<cr>", description = "List built in fuctions", opts = silent_opts },
				{
					"<leader>fo",
					":lua require'telescope.builtin'.oldfiles{}<cr>",
					description = "List old files",
					opts = silent_opts,
				},
				{ "<leader>fh", ":Telescope help_tags<cr>", description = "Vim help", opts = silent_opts },
				{ "<leader>fk", ":Telescope keymaps<cr>", description = "Keymaps", opts = silent_opts },
				{ "<leader>fO", ":Telescope vim_options<cr>", description = "Vim Options", opts = silent_opts },
				{
					"<leader>f/",
					":Telescope current_buffer_fuzzy_find<cr>",
					description = "Fuzzy find in buffer",
					opts = silent_opts,
				},
				{ "<leader>f?", ":Telescope search_history<cr>", description = "", opts = silent_opts },
				{ "<leader>f;", ":Telescope command_history<cr>", description = "Command History", opts = silent_opts },
				{
					"<leader>fC",
					":Telescope commands<cr>",
					description = "execute command History",
					opts = silent_opts,
				},
			},
		},

		{
			itemgroup = "Startify",
			keymaps = {
				{ "<leader>Sl", ":SLoad<cr>", description = "Load session", opts = silent_opts },
				{ "<leader>Sw", ":SSave<cr>", description = "Save session", opts = silent_opts },
				{ "<leader>Sd", ":SDelete<cr>", description = "Delete session", opts = silent_opts },
				{ "<leader>Sq", ":SClose<cr>", description = "Close session", opts = silent_opts },
			},
		},

		{
			itemgroup = "Spectre",
			description = "Spectre is tool to find and replace string in working directory",
			opts = silent_opts,
			keymaps = {
				{ ",fr", ":Spectre<CR>", description = "Find and replace", opts = silent_opts },
				{
					",fw",
					"<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
					description = "Find selected word",
					opts = silent_opts,
				},
				{
					",ff",
					":lua require('spectre').open_file_search()<cr>",
					description = "Find and replace in file",
					opts = silent_opts,
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

		-- TODO-comment
		{
			"<leader>ft",
			":TodoTelescope keywords=TODO,FIX,NOTE,BUG<cr>",
			description = "Find TODO comments",
			opts = silent_opts,
		},

		-- Lazy git
		{ "<leader>lg", ":LazyGit<CR>", description = "Open Lazy Git", opts = silent_opts },

		-- Github Copilot
		{
			"<C-Tab>",
			{ i = "<esc>:Copilot panel<CR>" },
			description = "Open Github Copilot panel",
			opts = silent_opts,
		},

		-- LSP
		{
			itemgroup = "LSP",
			keymaps = {

				{
					"gR",
					":Lspsagl lsp_finder<CR>",
					desgription = "Show definition and references",
					opts = silent_opts,
				},
				{
					"gd",
					":Lspsaga peek_definition<CR>",
					description = "Peek definition and make edits in window",
					opts = silent_opts,
				},
				{ "gD", ":Lspsaga goto_definition<CR>", description = "Go to definition", opts = silent_opts },
				{
					"gi",
					":lua vim.lsp.buf.implementation()<CR>",
					description = "Go to implementation",
					opts = silent_opts,
				},
				{ "<leader>ca", ":Lspsaga code_action<CR>", description = "Run code action", opts = silent_opts },
				{ "grn", ":Lspsaga rename<CR>", description = "Smart rename action", opts = silent_opts },
				{
					"<leader>D",
					":Lspsaga show_line_diagnostics<CR>",
					description = "Show line diagnostics",
					opts = silent_opts,
				},
				{
					"<leader>d",
					":Lspsaga show_cursor_diagnostics<CR>",
					description = "Show cursor diagnostics",
					opts = silent_opts,
				},
				{
					"[d",
					":Lspsaga diagnostic_jump_prev<CR>",
					description = "Jump to previous diagnostic",
					opts = silent_opts,
				},
				{
					"]d",
					":Lspsaga diagnostic_jump_next<CR>",
					description = "Jump to next diagnostic",
					opts = silent_opts,
				},
				{
					"gI",
					":Lspsaga hover_doc<CR>",
					description = "Show documentation under cursor",
					opts = silent_opts,
				},
				{ "<leader>so", ":SymbolsOutline<CR>", description = "Toggle Symbols Outline", opts = silent_opts },
				{
					"K",
					":lua require('lsp_signature').toggle_float_win()<cr>",
					description = "Toggle signature",
					opts = silent_opts,
				},
			},
		},

		-- Harpoon
		{
			itemgroup = "Harpoon",
			keymaps = {

				{
					"<leader>ha",
					":lua require('harpoon.mark').add_file()<cr>",
					description = "Add file to harpoon",
					opts = silent_opts,
				},
				{
					"<leader>ht",
					":lua require('harpoon.ui').toggle_quick_menu()<cr>",
					description = "Toggle Harpoon menu",
					opts = silent_opts,
				},
				{
					"<leader>h]",
					":lua require('harpoon.ui').nav_next()<cr>",
					description = "Navigate next",
					opts = silent_opts,
				},
				{
					"<leader>h[",
					":lua require('harpoon.ui').nav_prev()<cr>",
					description = "Navigate previous",
					opts = silent_opts,
				},
			},
		},

		-- Neotest
		{
			itemgroup = "NeoTest",
			keymaps = {
				{
					"<leader>tr",
					":lua require('neotest').run.run()<cr>",
					description = "Run nearest test",
					opts = silent_opts,
				},
				{
					"<leader>tl",
					":lua require('neotest').run.run_last()<cr>",
					description = "Run last test",
					opts = silent_opts,
				},
				{
					"<leader>tx",
					":lua require('neotest').run.stop()<cr>",
					description = "Stop testing",
					opts = silent_opts,
				},
				{
					"<leader>to",
					":lua require('neotest').output.open()<cr>",
					description = "Output",
					opts = silent_opts,
				},
				{
					"<leader>tO",
					":lua require('neotest').output_panel.toggle()<cr>",
					description = " Test Output panel",
					opts = silent_opts,
				},
				{
					"<leader>ts",
					":lua require('neotest').summary.toggle()<cr>",
					description = "Test Summary",
					opts = silent_opts,
				},
				-- { "<leader>Td", ":h neotest.diagnostic<cr>", description = "Test diagnostic" },
				-- { "<leader>Ts", ":h neotest.status<cr>", description = "Test status sign" },
				{
					"<leader>tf",
					":lua require('neotest').run.run(vim.fn.expand('%')) <cr>",
					description = "Run current file",
					opts = silent_opts,
				},
			},
		},
		{
			itemgroup = "Trouble",
			keymaps = {
				{ "<leader>xx", ":TroubleToggle<cr>", description = "Toggle Trouble", opts = silent_opts },
				{
					"<leader>xw",
					":TroubleToggle lsp_workspace_diagnostics<cr>",
					description = "Toggle workspace diagnostics",
					opts = silent_opts,
				},
				{
					"<leader>xd",
					":TroubleToggle lsp_document_diagnostics<cr>",
					description = "Toggle document diagnostics",
					opts = silent_opts,
				},
				{ "<leader>xl", ":TroubleToggle loclist<cr>", description = "Toggle loclist", opts = silent_opts },
				{ "<leader>xq", ":TroubleToggle quickfix<cr>", description = "Toggle quickfix", opts = silent_opts },
				{
					"<leader>xR",
					":TroubleToggle lsp_references<cr>",
					description = "Toggle references",
					opts = silent_opts,
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

vim.g.mapleader = " "

local keymap = vim.keymap
-- general keymaps
keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

keymap.set("n", "<leader>tt", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>t]", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>t[", ":tabp<CR>") -- go to previous tab

-- terminal
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- vim maximizer
keymap.set("n", "<C-w>m", ":MaximizerToggle<CR>")
keymap.set("n", "<leader>w", ":close<CR>")

-- NerdTree
keymap.set("n", "<leader>0", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>)", ":NvimTreeFocus<CR>")
keymap.set("n", "<leader>J", "<cmd>NvimTreeFindFile<cr>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>fp", "<cmd>Telescope builtin<cr>") -- built in functions panel
keymap.set("n", "<leader>fo", ":lua require'telescope.builtin'.oldfiles{}<cr>")

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- lazygit
-- keymap.set("n", "<leader>lg", ":LazyGit<CR>")

-- Spectre S
keymap.set("n", "<leader>sr", ":Spectre<CR>")
keymap.set("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>")
keymap.set("n", "<leader>sf", ":lua require('spectre').open_file_search()<cr>")

-- Telekasten
keymap.set("n", "<leader>zp", "<cmd>lua require('telekasten').panel()<cr>")
keymap.set("n", "<leader>zf", "<cmd>lua require('telekasten').find_notes()<cr>")
keymap.set("n", "<leader>zd", "<cmd>lua require('telekasten').find_daily_notes()<cr>")
keymap.set("n", "<leader>zg", "<cmd>lua require('telekasten').search_notes()<cr>")
keymap.set("n", "<leader>zz", "<cmd>lua require('telekasten').follow_link()<cr>")

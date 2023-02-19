-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

-- Fix copilot_cmp
-- local has_words_before = function()
-- 	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
-- 		return false
-- 	end
-- 	local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
-- end

-- local function has_words_before()
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		-- ["<CR>"] = cmp.mapping.confirm({ select = true }),
		cmp.setup({
			mapping = {
				["<CR>"] = cmp.mapping.confirm({
					-- this is the important line
					-- behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
			},
		}),

		-- Fix copilot_cmp
		-- ["<Tab>"] = vim.schedule_wrap(function(fallback)
		-- 	if cmp.visible() and has_words_before() then
		-- 		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
		-- 	else
		-- 		fallback()
		-- 	end
		-- end),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if require("copilot.suggestion").is_visible() then
		-- 		require("copilot.suggestion").accept()
		-- 	elseif cmp.visible() then
		-- 		cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
		-- 	elseif luasnip.expandable() then
		-- 		luasnip.expand()
		-- 	elseif has_words_before() then
		-- 		cmp.complete()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end),
	}),
	-- sources for autocompletion
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
		{ name = "neorg" }, -- file system paths
		{ name = "orgmode" },
		{ name = "copilot" },
	}),
	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},

	-- Fix copilot_cmp
	-- sorting = {
	-- 	priority_weight = 2,
	-- 	comparators = {
	-- 		require("copilot_cmp.comparators").prioritize,
	-- 		require("copilot_cmp.comparators").score,
	--
	-- 		-- Below is the default comparitor list and order for nvim-cmp
	-- 		cmp.config.compare.offset,
	-- 		-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
	-- 		cmp.config.compare.exact,
	-- 		cmp.config.compare.score,
	-- 		cmp.config.compare.recently_used,
	-- 		cmp.config.compare.locality,
	-- 		cmp.config.compare.kind,
	-- 		cmp.config.compare.sort_text,
	-- 		cmp.config.compare.length,
	-- 		cmp.config.compare.order,
	-- 	},
	-- },
})
-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

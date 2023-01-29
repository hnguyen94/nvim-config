local setup, orgmode = pcall(require, "orgmode")
if not setup then
	return
end

local status, org_bullets = pcall(require, "org-bullets")
if not status then
	return
end

local headlines_status, headlines = pcall(require, "headlines")
if not headlines_status then
	return
end

-- Load custom treesitter grammar for org filetype
orgmode.setup_ts_grammar()

-- Treesitter configuration
require("nvim-treesitter.configs").setup({
	-- If TS highlights are not enabled at all, or disabled via `disable` prop,
	-- highlighting will fallback to default Vim syntax highlighting
	highlight = {
		enable = true,
		-- Required for spellcheck, some LaTex highlights and
		-- code block highlights that do not have ts grammar
		additional_vim_regex_highlighting = { "org" },
	},
	ensure_installed = { "org" }, -- Or run :TSUpdate org
})
orgmode.setup({
	org_agenda_files = { "~/Documents/Orgmode/*" },
	org_default_notes_file = "~/Documents/Orgmode/main.org",
	org_todo_keywords = { "TODO", "WAITING", "|", "DONE", "DELEGATED" },
	org_todo_keyword_faces = {
		WAITING = ":foreground blue :weight bold",
		DELEGATED = ":background #FFFFFF :slant italic :underline on",
		TODO = ":background #000000 :foreground red", -- overrides builtin color for `TODO` keyword
	},
})

org_bullets.setup()
headlines.setup({
	markdown = {
		query = vim.treesitter.parse_query(
			"markdown",
			[[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
            ]]
		),
		headline_highlights = { "Headline" },
		codeblock_highlight = "CodeBlock",
		dash_highlight = "Dash",
		dash_string = "-",
		quote_highlight = "Quote",
		quote_string = "┃",
		fat_headlines = true,
		fat_headline_upper_string = "▃",
		fat_headline_lower_string = "",
	},
	rmd = {
		query = vim.treesitter.parse_query(
			"markdown",
			[[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
            ]]
		),
		treesitter_language = "markdown",
		headline_highlights = { "Headline" },
		codeblock_highlight = "CodeBlock",
		dash_highlight = "Dash",
		dash_string = "-",
		quote_highlight = "Quote",
		quote_string = "┃",
		fat_headlines = true,
		fat_headline_upper_string = "▃",
		fat_headline_lower_string = "",
	},
	norg = {
		query = vim.treesitter.parse_query(
			"norg",
			[[
                [
                    (heading1_prefix)
                    (heading2_prefix)
                    (heading3_prefix)
                    (heading4_prefix)
                    (heading5_prefix)
                    (heading6_prefix)
                ] @headline

                (weak_paragraph_delimiter) @dash
                (strong_paragraph_delimiter) @doubledash

                ((ranged_tag
                    name: (tag_name) @_name
                    (#eq? @_name "code")
                ) @codeblock (#offset! @codeblock 0 0 1 0))

                (quote1_prefix) @quote
            ]]
		),
		headline_highlights = { "Headline" },
		codeblock_highlight = "CodeBlock",
		dash_highlight = "Dash",
		dash_string = "-",
		doubledash_highlight = "DoubleDash",
		doubledash_string = "=",
		quote_highlight = "Quote",
		quote_string = "┃",
		fat_headlines = true,
		fat_headline_upper_string = "▃",
		fat_headline_lower_string = "",
	},
	org = {
		query = vim.treesitter.parse_query(
			"org",
			[[
                (headline (stars) @headline)

                (
                    (expr) @dash
                    (#match? @dash "^-----+$")
                )

                (block
                    name: (expr) @_name
                    (#eq? @_name "SRC")
                ) @codeblock

                (paragraph . (expr) @quote
                    (#eq? @quote ">")
                )
            ]]
		),
		headline_highlights = { "Headline" },
		codeblock_highlight = "CodeBlock",
		dash_highlight = "Dash",
		dash_string = "-",
		quote_highlight = "Quote",
		quote_string = "┃",
		fat_headlines = true,
		fat_headline_upper_string = "▃",
		fat_headline_lower_string = "",
	},
})

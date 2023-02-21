require("noice").setup({
	presets = {
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
	},
	routes = {
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				find = "%d+L, %d+B",
			},
			view = "mini",
		},
	},

	commands = {
		all = {
			-- options for the message history that you get with `:Noice`
			view = "split",
			opts = { enter = true, format = "details" },
			filter = {},
		},
	},

	lsp = {
		signature = {
			enabled = false,
		},
	},
})

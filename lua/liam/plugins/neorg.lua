local setup, neorg = pcall(require, "neorg")
if not setup then
	return
end

neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.norg.concealer"] = {},
		["core.integrations.telescope"] = {}, -- Enable the telescope module
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.keybinds"] = {
			config = {
				default_keybinds = true,
				hook = function(keybinds)
					keybinds.remap_event("norg", "n", "<leader>nn", "core.norg.dirman.new.note")
				end,
			},
		},
		["core.norg.dirman"] = {
			config = {
				default_workspace = "home",
				workspaces = {
					home = "~/Documents/Neorg/home",
				},
			},
		},
	},
})

local neorg_callbacks = require("neorg.callbacks")
neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
	-- Map all the below keybinds only when the "norg" mode is active
	keybinds.map_event_to_mode("norg", {
		n = { -- Bind keys in normal mode
			{ "<leader>fn", "core.integrations.telescope.find_linkable" },
		},

		i = { -- Bind in insert mode
			{ "<C-l>", "core.integrations.telescope.insert_link" },
		},
	}, {
		silent = true,
		noremap = true,
	})
end)

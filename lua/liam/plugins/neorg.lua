local setup, neorg = pcall(require, "neorg")
if not setup then
	return
end

neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.norg.concealer"] = {},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.keybinds"] = {
			config = {
				default_keybinds = true,
			},
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					home = "~/Documents/Neorg/home",
				},
			},
		},
	},
})

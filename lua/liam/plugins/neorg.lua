local setup, neorg = pcall(require, "neorg")
if not setup then
	return
end

neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.norg.concealer"] = {},
		["core.norg.completion"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					home = "~/Notes/",
				},
			},
		},
	},
})

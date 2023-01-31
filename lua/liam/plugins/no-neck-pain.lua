local status, no_neck_pain = pcall(require, "no-neck-pain")
if not status then
	return
end

no_neck_pain.setup({
	width = 115,
	toggleMapping = "<Leader>np",
	buffers = {
		backgroundColor = "#222935",
		textColor = "#ffffff",
		scratchPad = {
			-- set to `false` to
			-- disable auto-saving
			enabled = true,
			-- set to `nil` to default
			-- to current working directory
			location = "~/Documents/Neorg/code",
		},
		-- bo = {
		--   filetype = "md"
		-- },
	},
})

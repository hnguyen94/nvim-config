local setup, spectre = pcall(require, "spectre")
if not setup then
	return
end

spectre.setup()

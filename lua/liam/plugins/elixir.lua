-- import telescope plugin safely
local status, elixir = pcall(require, "elixir")
if not status then
	return
end

elixir.setup()

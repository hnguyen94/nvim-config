local status, mini_sessions = pcall(require, "mini.sessions")
if not status then
	return
end

mini_sessions.setup()

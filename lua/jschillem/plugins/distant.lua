local status, distant = pcall(require, "distant")
if not status then
	return
end

distant:setup()

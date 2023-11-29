function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	if raw then return s end
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end

function getMacOSVersion()
	return os.capture("sw_vers -productVersion")
end

function getMacOSVersionMajor()
	return tonumber(string.match(getMacOSVersion(), "^(%d+)%..*$"))
end

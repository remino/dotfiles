lib = {}

function lib.exec(cmd, success, failure)
	local out, ok, _, rc = hs.execute(cmd)

	if ok then
		if success then
			success(out)
		end
	else
		if failure then
			failure(out, rc)
		end
	end
end

function lib.trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

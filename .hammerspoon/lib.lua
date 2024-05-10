lib = {}

function lib.copyTableExcept(original, excludedKeys)
	local copy = {}

	for key, value in pairs(original) do
		if not lib.tableContains(excludedKeys, key) then
			copy[key] = value
		end
	end

	return copy
end

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

function lib.mergeTables(...)
	local result = {}

	for _, tbl in ipairs({...}) do
		for k, v in pairs(tbl) do
			result[k] = v
		end
	end

	return result
end

function lib.tableContains(table, element)
	for _, value in ipairs(table) do
			if value == element then
					return true
			end
	end
	return false
end

function lib.trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

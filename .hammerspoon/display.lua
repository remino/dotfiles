local function requireDisplayplacer()
	local _, ok, _, rc = hs.execute("displayplacer --version", true)

	if ok and rc == 0 then
		return true
	end

	return false
end

local function rotateScreen()
	local screen = hs.mouse.getCurrentScreen()
	local currentRotation = screen:rotate()

	if not requireDisplayplacer() then
		hs.alert.show("displayplacer not found", {}, screen)
		return
	end

	local id = screen:id()
	local newRotation = 0

	if currentRotation == 0 then
		newRotation = 90
	end

	local command = '/opt/homebrew/bin/displayplacer "id:' .. id .. ' degree:' .. newRotation .. '"'

	local _, ok, _, rc = hs.execute(command)

	if not ok then
		hs.alert.show('Screen rotate failed: ' .. rc)
		return
	end

	screen = hs.screen(id)

	local frame = screen:frame()
	hs.mouse.setRelativePosition({x = frame.x + frame.w / 2, y = frame.y + frame.h / 2}, screen)

	hs.alert.show("Screen rotated", {}, screen)
end

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "D", rotateScreen)

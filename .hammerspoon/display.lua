local angles = { 0, 90, 180, 270 }

local function requireDisplayplacer()
	local _, ok, _, rc = hs.execute("displayplacer --version", true)

	if ok and rc == 0 then
		return true
	end

	return false
end

local function rotateDisplay(newAngle)
	local screen = hs.mouse.getCurrentScreen()

	if not requireDisplayplacer() then
		hs.alert.show("displayplacer not found", {}, screen)
		return
	end

	local id = screen:id()

	if newAngle == nil then
		if screen:rotate() == 0 then
			newAngle = 90
		else
			newAngle = 0
		end
	end

	local command = '/opt/homebrew/bin/displayplacer "id:' .. id .. ' degree:' .. newAngle .. '"'

	local _, _, _, rc = hs.execute(command)

	screen = hs.screen(id)

	local frame = screen:frame()
	hs.mouse.setRelativePosition({x = frame.x + frame.w / 2, y = frame.y + frame.h / 2}, screen)

	hs.alert.show("Display rotated", {}, screen)
end

menu.registerCommand("display:rotate", "Display: Rotate", rotateDisplay)

hs.fnutils.each(angles, function(angle)
	menu.registerCommand(
		string.format("display:rotate:%d", angle),
		string.format("Display: Rotate %dº", angle),
		function() rotateDisplay(angle) end
	)
end)

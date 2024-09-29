local windowAlertStyle = {
	strokeWidth = 2,
	strokeColor = { white = 1, alpha = 0.25 },
	fillColor = { white = 0, alpha = 0.75 },
	textColor = { white = 1, alpha = 1 },
	textFont = "Helvetica Neue",
	textSize = 24,
	radius = 24,
	atScreenEdge = 0,
	fadeInDuration = 0,
	fadeOutDuration = 0.30,
}

function moveMouseToFocusedWindow()
	local win = hs.window.focusedWindow()

	if not win then
		return
	end

	local title = win:application():title()
	local frame = win:frame()
	local screen = win:screen()
	local center = hs.geometry.rectMidPoint(frame)
	hs.mouse.setAbsolutePosition(center)
	hs.alert.show(" " .. title .. " ", windowAlertStyle, screen, 1)
end

local function getCurrentScreen()
	local pos = hs.mouse.absolutePosition()
	local screen = hs.fnutils.find(hs.screen.allScreens(), function(s)
		return hs.geometry.rect(pos.x, pos.y, 1, 1):inside(s:fullFrame())
	end)
	return screen
end

local function getNextScreen(screen)
	local screens = hs.screen.allScreens()
	local index = hs.fnutils.indexOf(screens, screen)
	local nextIndex = index % #screens + 1
	return screens[nextIndex]
end

local function centerMouse(screen)
	print("centerMouseOnScreen")

	local moveToNextScreen = false
	local oldPos = hs.mouse.absolutePosition()

	if not screen then
		screen = getCurrentScreen()
		moveToNextScreen = true
	end

	local screen = screen or hs.screen.mainScreen()
	local center = hs.geometry.rectMidPoint(screen:fullFrame())
	local newPos = hs.mouse.absolutePosition(center)

	if moveToNextScreen and oldPos.x == newPos.x and oldPos.y == newPos.y then
		centerMouse(getNextScreen(screen))
	end
end

local function centerMouseOnPrimaryScreen()
	print("centerMouseOnPrimaryScreen")
	centerMouse(hs.screen.primaryScreen())
end

local commands = {
	{
		text = "Mouse: Center on Current Screen",
		id = "mouse:center",
		callback = function() centerMouse() end
	},
	{
		text = "Mouse: Center on Primary Screen",
		id = "mouse:center-on-primary-screen",
		callback = centerMouseOnPrimaryScreen
	}
}

hs.hotkey.bind({"cmd", "ctrl", "shift"}, "m", centerMouse)
hs.hotkey.bind({"cmd", "ctrl", "option", "shift"}, "m", centerMouseOnPrimaryScreen)
menu.registerCommands(commands)

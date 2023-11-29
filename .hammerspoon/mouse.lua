windowAlertStyle = {
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

hs.hotkey.bind({"cmd", "ctrl", "shift"}, "m", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local center = hs.geometry.rectMidPoint(screen:fullFrame())
	hs.mouse.setAbsolutePosition(center)
end)

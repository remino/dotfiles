hs.hotkey.bind({"cmd", "ctrl", "shift"}, "m", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local center = hs.geometry.rectMidPoint(screen:fullFrame())
	hs.mouse.setAbsolutePosition(center)
end)

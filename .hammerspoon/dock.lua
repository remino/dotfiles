function focusDockApp(num)
	ok, result = hs.osascript.applescript(string.format([[
		tell application "System Events"
			click UI element %d of list 1 of process "Dock"
		end tell
	]], num))
	
	if not ok then
		hs.alert.show("Error focusing dock app")
		return
	end

	moveMouseToFocusedWindow()
end

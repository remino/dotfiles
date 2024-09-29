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

autoHide = false
dock = {}

function dock.show()
	ok, result = hs.osascript.applescript([[
		tell application "System Events"
			tell dock preferences
				get autohide
			end tell
		end tell
	]])

	if not ok then
		hs.alert.show("Error showing dock")
		return
	end

	autoHide = result

	hs.osascript.applescript([[
		tell application "System Events"
			tell dock preferences
				set autohide to false
			end tell
		end tell
	]])
end

function dock.hide()
	if not autoHide then
		return
	end

	hs.osascript.applescript([[
		tell application "System Events"
			tell dock preferences
				set autohide to true
			end tell
		end tell
	]])
end

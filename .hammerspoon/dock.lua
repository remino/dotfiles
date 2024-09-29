dock = {
	autoHide = false
}

function dock.focusApp(num)
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

	dock.autoHide = result

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

local function registerUrlEvents()
	hs.urlevent.bind("dock", function(eventName, params)
		if params["action"] == "focusApp" then
			dock.focusApp(tonumber(params["n"]))
			return
		end

		if params["action"] == "hide" then
			dock.hide()
			return
		end

		if params["action"] == "show" then
			dock.show()
			return
		end
	end)
end

registerUrlEvents()

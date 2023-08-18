--[[
########  ######## ##        #######     ###    ########
##     ## ##       ##       ##     ##   ## ##   ##     ##
##     ## ##       ##       ##     ##  ##   ##  ##     ##
########  ######   ##       ##     ## ##     ## ##     ##
##   ##   ##       ##       ##     ## ######### ##     ##
##    ##  ##       ##       ##     ## ##     ## ##     ##
##     ## ######## ########  #######  ##     ## ########
]]

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "R", function()
	hs.fnutils.partial(hs.reload, self)
	hs.alert.show("HammerSpoon Config Reloaded")
end)

--[[
 ######  ########   #######   #######  ##    ##  ######
##    ## ##     ## ##     ## ##     ## ###   ## ##    ##
##       ##     ## ##     ## ##     ## ####  ## ##
 ######  ########  ##     ## ##     ## ## ## ##  ######
      ## ##        ##     ## ##     ## ##  ####       ##
##    ## ##        ##     ## ##     ## ##   ### ##    ##
 ######  ##         #######   #######  ##    ##  ######
]]

hs.loadSpoon("FnMate")
spoon.FnMate:init()

hs.loadSpoon("MouseFollowsFocus")
spoon.MouseFollowsFocus:start()

--[[
 ######  ##        #######   ######  ##    ##
##    ## ##       ##     ## ##    ## ##   ##
##       ##       ##     ## ##       ##  ##
##       ##       ##     ## ##       #####
##       ##       ##     ## ##       ##  ##
##    ## ##       ##     ## ##    ## ##   ##
 ######  ########  #######   ######  ##    ##
]]

hs.loadSpoon("AClock")
spoon.AClock["textColor"] = {hex="#000000", alpha=0.8}
spoon.AClock["textFont"] = "Helvetica Neue"
spoon.AClock["textSize"] = 120
spoon.AClock["format"] = "%Y-%m-%d\n%A\n%H:%M:%S"
spoon.AClock["height"] = 600
spoon.AClock["width"] = 800
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "C", function()
	spoon.AClock:toggleShow()
end)

--[[
##    ## ######## ##    ## ########   #######     ###    ########  ########
##   ##  ##        ##  ##  ##     ## ##     ##   ## ##   ##     ## ##     ##
##  ##   ##         ####   ##     ## ##     ##  ##   ##  ##     ## ##     ##
#####    ######      ##    ########  ##     ## ##     ## ########  ##     ##
##  ##   ##          ##    ##     ## ##     ## ######### ##   ##   ##     ##
##   ##  ##          ##    ##     ## ##     ## ##     ## ##    ##  ##     ##
##    ## ########    ##    ########   #######  ##     ## ##     ## ########
]]

keyboardAlert = nil
currentLayout = hs.keycodes.currentSourceID()

keyboardLayoutTable = {
	EN = {"com.apple.keylayout.Canadian", "0"},
	FR = {"com.apple.keylayout.Canadian-CSA", "9"},
	JA = {"com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese", "8"},
}

keyboardAlertStyle = {
	strokeWidth = 2,
	strokeColor = { white = 1, alpha = 0.25 },
	fillColor = { white = 0, alpha = 0.75 },
	textColor = { white = 1, alpha = 1 },
	textFont = "Helvetica Neue",
	textSize = 36,
	radius = 12,
	atScreenEdge = 0,
	fadeInDuration = 0,
	fadeOutDuration = 0.30,
}

function formatKeyboardLayoutAlert(layoutName)
	for key, layout in pairs(keyboardLayoutTable) do
		if layout[1] == layoutName then
			return "⌨️ " .. key
		end
	end

	return "⌨️ " .. layoutName
end

function switchKeyboardLayout(sourceID)
	hs.keycodes.currentSourceID(sourceID)
end

hs.keycodes.inputSourceChanged(function()
	newLayout = hs.keycodes.currentSourceID()

	if currentLayout ~= newLayout then
		currentLayout = newLayout

		if keyboardAlert ~= nil then
			hs.alert.closeSpecific(keyboardAlert)
		end

		keyboardAlert = hs.alert.show(
			formatKeyboardLayoutAlert(currentLayout),
			keyboardAlertStyle,
			hs.screen.mainScreen(),
			1
		)
	end
end)

for key, layout in pairs(keyboardLayoutTable) do
	hs.hotkey.bind({"cmd", "shift", "ctrl"}, layout[2], function()
		switchKeyboardLayout(layout[1])
	end)
end

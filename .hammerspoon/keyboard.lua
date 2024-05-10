keyboardAlert = nil
currentLayout = hs.keycodes.currentSourceID()

keyboardLayoutTable = {
	EN = {"com.apple.keylayout.Canadian", "0"},
	FR = {"com.apple.keylayout.Canadian-CSA", "9"},
	JA = {"com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese", "8"},
}

function formatKeyboardLayoutAlert(layoutName)
	for key, layout in pairs(keyboardLayoutTable) do
		if layout[1] == layoutName then
			return " ⌨️ " .. key:lower() .. " "
		end
	end

	return " ⌨️ " .. layoutName .. " "
end

local function setFunctioKeysAsMediaKeys()
	local _, ok, _, rc = hs.execute("defaults write -g com.apple.keyboard.fnState -bool false")

	if not ok then
		hs.alert.show("Failed to set function keys", 0.5)
		return
	end

	hs.alert.show("Function keys as media keys", 0.5)
end

local function setFunctionKeysAsFKeys()
	local _, ok, _, rc = hs.execute("defaults write -g com.apple.keyboard.fnState -bool true")

	if not ok then
		hs.alert.show("Failed to set function keys", 0.5)
		return
	end

	hs.alert.show("Function keys as F keys", 0.5)
end

local function toggleFunctionKeys()
	-- get system preference via CLI
	local functionKeysEnabled = hs.execute("defaults read -g com.apple.keyboard.fnState")

	if tonumber(functionKeysEnabled) == 1 then
		setFunctioKeysAsMediaKeys()
	else
		setFunctionKeysAsFKeys()
	end
end

function switchKeyboardLayout(sourceID)
	hs.keycodes.currentSourceID(sourceID)
end

if getMacOSVersionMajor() < 14 then
	keyboardAlertStyle = {
		strokeWidth = 2,
		strokeColor = { white = 1, alpha = 0.25 },
		fillColor = { white = 0, alpha = 0.75 },
		textColor = { white = 1, alpha = 1 },
		textFont = "Helvetica Neue",
		textSize = 36,
		radius = 36,
		atScreenEdge = 0,
		fadeInDuration = 0,
		fadeOutDuration = 0.30,
	}
	
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
end

for key, layout in pairs(keyboardLayoutTable) do
	hs.hotkey.bind({"cmd", "shift", "ctrl"}, layout[2], function()
		switchKeyboardLayout(layout[1])
	end)
end

local composeKeyWatch = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
	-- 102 = Japanese eisu (英数) key
	if event:getKeyCode() == 102 and hs.keycodes.currentSourceID() == keyboardLayoutTable["EN"][1] then
		hs.eventtap.keyStroke({}, "§", 0)
	end
end)

local commands = {
	{
		text = "Function Keys: Toggle",
		id = "keyboard:fnKeys:toggle",
		callback = toggleFunctionKeys
	},
	{
		text = "Function Keys: As Media Keys",
		id = "keyboard:fnKeys:media",
		callback = setFunctioKeysAsMediaKeys
	},
	{
		text = "Function Keys: As F Keys",
		id = "keyboard:fnKeys:fKeys",
		callback = setFunctionKeysAsFKeys
	}
}

composeKeyWatch:start()
menu.registerCommands(commands)

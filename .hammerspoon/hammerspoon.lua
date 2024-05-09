hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local choices = {
	{
		text = "Reload Hammerspoon Config",
		id = "reload"
	},
	{
		text = "Show Hammerspoon Console",
		id = "console"
	}
}

local function reloadConfig()
	print("hammerspoon: Config reloaded.")
	hs.reload()
	hs.alert.show("Hammerspoon Config Reloaded")
end

local function toggleConsole()
	local window = hs.console.hswindow()

	if window then
		hs.closeConsole()
	else
		hs.openConsole()
	end
end

local function runCommand(data)
	if not data then
		return
	end

	local id = data.id

	if id == "reload" then
		reloadConfig()
	elseif id == "console" then
		toggleConsole()
	end
end

local function setConsoleDarkMode()
	hs.console.darkMode(true)
	hs.console.outputBackgroundColor{ white = 0 }
	hs.console.consoleCommandColor{ white = 1 }
	hs.console.alpha(1)
end

local function showMenu()
	chooser = hs.chooser.new(runCommand)

	chooser:choices(choices)
	chooser:rows(#choices)
	chooser:bgDark(true)

	chooser:show()
end

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "H", showMenu)

setConsoleDarkMode()

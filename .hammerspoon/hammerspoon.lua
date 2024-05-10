hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

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

local choices = {
	{
		text = "Hammerspoon: Toggle Console",
		id = "hs:console",
		callback = toggleConsole
	},
	{
		text = "Hammerspoon: Reload Config",
		id = "hs:reload",
		callback = reloadConfig
	}
}

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

setConsoleDarkMode()
menu.registerCommands(choices)

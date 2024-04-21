hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "R", function()
	print("HammerSpoon Config Reloaded")
	hs.reload()
	hs.alert.show("HammerSpoon Config Reloaded")
end)

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "R", function()
	hs.fnutils.partial(hs.reload, self)
	hs.alert.show("HammerSpoon Config Reloaded")
end)

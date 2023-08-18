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

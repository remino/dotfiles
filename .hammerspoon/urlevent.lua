hs.urlevent.bind("focusDockApp", function(eventName, params)
	focusDockApp(tonumber(params["n"]))
end)

hs.urlevent.bind("dock", function(eventName, params)
	if params["action"] == "hide" then
		dock.hide()
		return
	end

	if params["action"] == "show" then
		dock.show()
		return
	end
end)

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

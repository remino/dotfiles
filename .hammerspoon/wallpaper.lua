wallpaper = {}

function wallpaper.reset()
  os.execute(os.getenv("HOME") .. "/bin/wallpaper")
end

function wallpaper.updateOnWake(eventType)
	hs.caffeinate.watcher.new(function(eventType)
		if (eventType == hs.caffeinate.watcher.systemDidWake) then
			wallpaper.reset()
		end
	end):start()
end

hs.hotkey.bind({"cmd", "shift", "ctrl"}, 'p', function()
	wallpaper.reset()
end)

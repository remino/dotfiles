function resetWallpaper()
  os.execute(os.getenv("HOME") .. "/bin/wallpaper")
end

hs.caffeinate.watcher.new(function(eventType)
  if (eventType == hs.caffeinate.watcher.systemDidWake) then
    resetWallpaper()
  end
end):start()

hs.hotkey.bind({"cmd", "shift", "ctrl"}, 'p', function()
  resetWallpaper()
end)

function include_if_exists(filename)
	local file = io.open(filename, "r")
	if file then
		file:close()
		dofile(filename)
	end
end

includes = {
	"lib",
	"hammerspoon",
	"spoons",
	"os",
	"clock",
	"display",
	"keyboard",
	"mouse",
	"dock",
	"urlevent",
	"wallpaper",
	"local",
}

for _, file in pairs(includes) do
	include_if_exists(hs.spoons.resourcePath(file .. ".lua"))
end

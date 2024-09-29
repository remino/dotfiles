menu = {}
menu.chooser = nil

function menu.registerCommand(id, text, callback, options)
	options = options or {}

	table.insert(menu.commands, lib.mergeTables(options, {
		id = id,
		text = text,
		callback = callback,
	}))
end

function menu.registerCommands(commands)
	for _, command in ipairs(commands) do
		menu.registerCommand(
			command.id,
			command.text,
			command.callback,
			lib.copyTableExcept(command, {"text", "id", "callback"})
		)
	end
end

local function helloWorld()
	hs.alert.show("Hello World")
end

menu.commands = {
	-- {
	-- 	text = "Hello World",
	-- 	id = "hello",
	-- 	callback = helloWorld
	-- }
}

local function constructMenuChoices()
	local choices = {}

	for _, command in ipairs(menu.commands) do
		table.insert(choices, lib.copyTableExcept(command, {"callback"}))
	end

	return choices
end

local function runCommand(data)
	if not data then
		return
	end

	local id = data.id

	for _, command in ipairs(menu.commands) do
		if command.id == id then
			command.callback(data)
			return
		end
	end
end

local function toggleMenu()
	if menu.chooser and menu.chooser:isVisible() then
		menu.chooser:hide()
		menu.chooser:delete()
		menu.chooser = nil
		return
	end

	menu.chooser = hs.chooser.new(runCommand)

	menu.chooser:choices(constructMenuChoices())
	menu.chooser:bgDark(true)

	menu.chooser:show()
end

hs.hotkey.bind({"ctrl", "option"}, "space", toggleMenu)

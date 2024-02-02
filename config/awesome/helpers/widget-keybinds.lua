local awful = require("awful")

return function(widget, keys)
	local function toggle()
		if widget.toggle ~= nil then
			widget.toggle()
		else
			widget.visible = not widget.visible
		end
	end

	-- Start a keygrabber to use keyboard shortcuts while the widget is visible
	keys = keys or {}
	keys[#keys + 1] = awful.key({
		modifiers = {},
		key = "Escape",
		on_press = toggle,
	})
	local keygrabber = awful.keygrabber({
		keybindings = keys,
	})

	-- Hide widget when clicking outside it
	widget:connect_signal("mouse::leave", function()
		button.connect_signal("press", toggle)
	end)

	widget:connect_signal("mouse::enter", function()
		button.disconnect_signal("press", toggle)
	end)

	widget:connect_signal("property::visible", function(self)
		if self.visible then
			button.connect_signal("press", toggle)
			keygrabber:start()
		else
			button.disconnect_signal("press", toggle)
			keygrabber:stop()
		end
	end)
end

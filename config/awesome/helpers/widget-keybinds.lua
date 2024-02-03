return function(widget, keys)
	local function toggle()
		if widget.toggle ~= nil then
			widget.toggle()
		else
			widget.visible = not widget.visible
		end
	end

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
		else
			button.disconnect_signal("press", toggle)
		end
	end)
end

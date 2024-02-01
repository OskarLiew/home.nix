local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local buffer = wibox.widget({
	layout = wibox.layout.fixed.vertical,
})

local add_button_event = function(widget)
	widget:buttons(gears.table.join(
		awful.button({}, 5, nil, function()
			if #widget.children <= 1 then
				return
			end
			buffer:insert(#buffer.children + 1, widget.children[1])
			widget:remove(1)
		end),
		awful.button({}, 4, nil, function()
			if #buffer.children == 0 then
				return
			end
			widget:insert(1, buffer.children[#buffer.children])
			buffer:remove(#buffer.children)
		end)
	))
end

return add_button_event

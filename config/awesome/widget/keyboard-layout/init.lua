local wibox = require("wibox")
local widget = require("awful.widget")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi

local clickable_container = require("widget.clickable-container")

local icons = beautiful.icons.misc

local keyboard_imagebox = wibox.widget({
	nil,
	{
		id = "icon",
		image = icons.keyboard,
		widget = wibox.widget.imagebox,
		resize = true,
	},
	nil,
	expand = "none",
	layout = wibox.layout.align.vertical,
	widget = clickable_container,
})

keyboard_imagebox:buttons(gears.table.join(awful.button({}, 1, nil, function()
	widget.keyboardlayout():next_layout()
end)))

local keyboard_widget = wibox.widget({
	layout = wibox.layout.fixed.horizontal,
	spacing = dpi(2),
	keyboard_imagebox,
	widget.keyboardlayout(),
})

local keyboard_button = wibox.widget({
	{
		keyboard_widget,
		widget = wibox.container.margin,
		left = dpi(4),
		right = dpi(2),
	},
	widget = clickable_container,
})

return keyboard_button

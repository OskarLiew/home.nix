local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local clickable_container = require("widget.clickable-container")
local init_icon = require("helpers.icon").init_icon
local icons = beautiful.icons.misc

local function init_calendar_widget()
	local display_date = os.date("*t")
	local current_date = os.date("*t")

	local function init_calendar(d)
		return wibox.widget({
			widget = wibox.widget.calendar.month,
			date = d,
			week_numbers = true,
		})
	end

	local cal = wibox.widget({
		init_calendar(current_date),
		widget = wibox.container.margin,
	})

	local function prev_month(d)
		if d.month == 1 then
			d.month = 12
			d.year = d.year - 1
		else
			d.month = d.month - 1
		end
		d.day = nil

		if d.month == current_date.month and d.year == current_date.year then
			d.day = current_date.day
		end
	end

	local function next_month(d)
		if d.month == 12 then
			d.month = 1
			d.year = d.year + 1
		else
			d.month = d.month + 1
		end
		d.day = nil

		if d.month == current_date.month and d.year == current_date.year then
			d.day = current_date.day
		end
	end

	-- Create buttons
	local left = wibox.widget({
		init_icon(icons.left, dpi(24), beautiful.gray1),
		widget = clickable_container,
	})
	left:buttons(gears.table.join(awful.button({}, 1, nil, function()
		prev_month(display_date)
		local c = init_calendar(display_date)
		cal:set_widget(c)
	end)))
	local right = wibox.widget({
		init_icon(icons.right, dpi(24), beautiful.gray1),
		widget = clickable_container,
	})
	right:buttons(gears.table.join(awful.button({}, 1, nil, function()
		next_month(display_date)
		local c = init_calendar(display_date)
		cal:set_widget(c)
	end)))

	local widget = wibox.widget({
		{
			{ left, widget = wibox.container.place, valign = "top" },
			cal,
			{ right, widget = wibox.container.place, valign = "top" },
			layout = wibox.layout.fixed.horizontal,
			spacing = dpi(12),
		},
		widget = wibox.container.margin,
	})

	return widget
end

return init_calendar_widget

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local clickable_container = require("widget.clickable-container")
local init_icon = require("helpers.icon").init_icon
local icons = beautiful.icons.misc

local function init_calendar_widget(fontsize)
	fontsize = fontsize or 14

	local display_date = os.date("*t")
	local current_date = os.date("*t")

	local function init_calendar(day)
		local styles = {}

		local function circle(cr, width, height)
			return gears.shape.circle(cr, width, height, fontsize)
		end

		styles.month = {}
		styles.normal = {}
		styles.focus = {
			fg_color = beautiful.fg_focus,
			markup = function(t)
				return "<b>" .. t .. "</b>"
			end,
			shape = circle,
			bg_color = beautiful.bg_focus,
		}
		styles.header = {
			markup = function(t)
				return "<b>" .. t .. "</b>"
			end,
		}
		styles.weekday = {
			fg_color = beautiful.fg,
			markup = function(t)
				return "<b>" .. t .. "</b>"
			end,
		}
		styles.weeknumber = {
			fg_color = beautiful.gray0,
			markup = function(t)
				return "<i>" .. t .. "</i>"
			end,
		}
		local function decorate_cell(widget, flag, date)
			if flag == "monthheader" and not styles.monthheader then
				flag = "header"
			end
			local props = styles[flag] or {}
			if props.markup and widget.get_text and widget.set_markup then
				widget:set_markup(props.markup(widget:get_text()))
			end

			-- Change bg color for weekends
			local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
			local weekday = tonumber(os.date("%w", os.time(d)))
			local default_fg = weekday == 0 and beautiful.red or beautiful.fg
			local ret = wibox.widget({
				{
					widget,
					margins = (props.padding or 2) + (props.border_width or 0),
					widget = wibox.container.margin,
				},
				shape = props.shape,
				fg = props.fg_color or default_fg,
				bg = props.bg_color,
				widget = wibox.container.background,
			})
			return ret
		end

		return wibox.widget({
			widget = wibox.widget.calendar.month,
			fn_embed = decorate_cell,
			date = day,
			week_numbers = true,
			font = "Monospace " .. tostring(fontsize),
			flex_height = true,
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
			{ left, widget = wibox.container.place, valign = "center" },
			cal,
			{ right, widget = wibox.container.place, valign = "center" },
			layout = wibox.layout.fixed.horizontal,
			spacing = dpi(12),
		},
		widget = wibox.container.place,
	})

	return widget
end

return init_calendar_widget

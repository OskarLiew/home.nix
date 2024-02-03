local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")

local wibox = require("wibox")

local naughty = require("naughty")

local clickable_container = require("widget.clickable-container")

local function get_notif_template(n)
	local action = {
		base_layout = wibox.widget({
			spacing = 12,
			layout = wibox.layout.fixed.horizontal,
		}),
		widget_template = {
			{
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					widget = wibox.container.margin,
					left = dpi(12),
					right = dpi(12),
					top = dpi(4),
					bottom = dpi(4),
				},
				widget = clickable_container,
			},
			shape = function(cr, w, h)
				gears.shape.rounded_rect(cr, w, h, dpi(4))
			end,
			bg = beautiful.notification_action_bg_normal,
			widget = wibox.container.background,
		},
		widget = naughty.list.actions,
	}

	return {
		{
			{
				widget = wibox.widget.imagebox,
				image = n.icon,
				resize = true,
				clip_shape = function(cr, w, h)
					gears.shape.rounded_rect(cr, w, h, dpi(6))
				end,
			},
			widget = wibox.container.constraint,
			width = dpi(42),
			strategy = "max",
		},
		{
			{
				{
					font = beautiful.notification_font or "Sans 12",
					markup = "<b>" .. n.title .. "</b>",
					widget = wibox.widget.textbox,
				},
				{
					markup = n.message,
					widget = wibox.widget.textbox,
				},
				widget = wibox.layout.fixed.vertical,
				spacing = dpi(6),
			},
			{
				widget = wibox.container.margin,
				top = dpi(12),
				visible = n.actions and #n.actions > 0,
			},
			action,
			widget = wibox.layout.fixed.vertical,
		},
		widget = wibox.layout.fixed.horizontal,
		spacing = dpi(12),
	}
end

return get_notif_template

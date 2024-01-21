local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")

local wibox = require("wibox")

local naughty = require("naughty")

local ruled = require("ruled")

local clickable_container = require("widget.clickable-container")

ruled.notification.connect_signal("request::rules", function()
	-- All notifications will match this rule.
	ruled.notification.append_rule({
		rule = {},
		properties = {
			screen = awful.screen.preferred,
			implicit_timeout = 5,
			position = "bottom_right",
		},
	})
end)

naughty.connect_signal("request::display", function(n)
	local action = {
		base_layout = wibox.widget({
			spacing = 12,
			layout = wibox.layout.fixed.horizontal,
		}),
		widget_template = {
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
			shape = function(cr, w, h)
				gears.shape.rounded_rect(cr, w, h, dpi(4))
			end,
			widget = clickable_container,
			bg = beautiful.notification_action_bg_normal,
		},
		widget = naughty.list.actions,
	}

	return naughty.layout.box({
		notification = n,
		widget_template = {
			{
				{
					{
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
								naughty.widget.message,
								widget = wibox.layout.fixed.vertical,
								spacing = dpi(6),
							},
							action,
							widget = wibox.layout.fixed.vertical,
							spacing = dpi(12),
						},
						widget = wibox.layout.fixed.horizontal,
						spacing = dpi(12),
					},
					widget = wibox.container.margin,
					margins = dpi(12),
				},
				widget = naughty.container.background,
				id = "backgorund_role",
			},
			widget = wibox.container.constraint,
			width = dpi(372),
			strategy = "exact",
		},
	})
end)

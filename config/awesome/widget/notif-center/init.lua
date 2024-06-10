local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local init_icon = require("helpers.icon").init_icon
local clickable_container = require("widget.clickable-container")

local function init_notification_center()
	-- Define widgets
	local title = wibox.widget({
		{
			widget = wibox.widget.textbox,
			text = "Notifications",
			font = beautiful.base_font .. ", bold 20",
			align = "center",
		},
		widget = wibox.container.margin,
		bottom = dpi(6),
	})

	local notif_list = require("widget.notif-center.notif-list")
	local notifications = wibox.widget({
		notif_list,
		widget = wibox.container.margin,
		top = dpi(6),
		bottom = dpi(6),
	})

	local clear_button = wibox.widget({
		{
			{
				{
					{
						{
							widget = wibox.widget.textbox,
							text = "Clear notifications",
							font = beautiful.base_font .. " 12",
						},
						init_icon(beautiful.icons.misc.delete, dpi(20), beautiful.fg),
						layout = wibox.layout.fixed.horizontal,
						spacing = dpi(12),
					},
					widget = wibox.container.place,
				},
				widget = wibox.container.background,
				bg = beautiful.bg_red,
				forced_height = dpi(36),
				shape = function(cr, w, h)
					gears.shape.rounded_rect(cr, w, h, dpi(18))
				end,
			},
			widget = clickable_container,
		},
		widget = wibox.container.margin,
		left = dpi(24),
		right = dpi(24),
	})
	clear_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
		notif_list:reset()
	end)))

	return wibox.widget({
		title,
		notifications,
		clear_button,
		layout = wibox.layout.align.vertical,
		fill_space = true,
		spacing = dpi(6),
	})
end

return init_notification_center

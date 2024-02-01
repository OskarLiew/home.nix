local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local get_notif_template = require("daemon.notifications")
local function get_notification(n)
	local time_ago = wibox.widget({
		widget = wibox.widget.textbox,
		font = beautiful.base_font .. " 9",
		text = n.get_duration(),
		halign = "right",
	})
	awesome.connect_signal("notif-center::opened", function()
		time_ago.text = n.get_duration()
	end)
	local color = beautiful.notification_bg
	if n.urgency == "critical" then
		color = beautiful.notification_bg_urgent
	end

	local notif = wibox.widget({
		{
			{
				{
					{
						widget = wibox.widget.textbox,
						font = beautiful.base_font .. " 9",
						text = n.app_name,
						halign = "left",
					},
					time_ago,
					layout = wibox.layout.flex.horizontal,
				},
				get_notif_template(n),
				layout = wibox.layout.fixed.vertical,
				spacing = dpi(6),
			},
			widget = wibox.container.margin,
			margins = dpi(12),
		},
		widget = wibox.container.background,
		bg = color,
		shape = beautiful.notification_shape,
	})

	return notif
end

local notifbox_layout = wibox.widget({
	layout = wibox.layout.fixed.vertical,
	spacing = dpi(6),
})
require("layout.notif-center.notif-scroller")(notifbox_layout)

local notifbox_add = function(n)
	notifbox_layout:insert(1, get_notification(n))
end

local notifbox_add_expired = function(n)
	n:connect_signal("destroyed", function(_, reason, _)
		if reason == 1 then
			notifbox_add(n)
		end
	end)
end

naughty.connect_signal("request::display", function(n)
	local timestamp = os.time()
	n.get_duration = function()
		local difference = math.abs(timestamp - os.time())

		if difference < 60 then
			return tostring(difference) .. "s ago"
		elseif difference < 3600 then
			local minutes = math.floor(difference / 60)
			return tostring(minutes) .. "m ago"
		elseif difference < 86400 then
			local hours = math.floor(difference / 3600)
			return tostring(hours) .. "h ago"
		else
			local days = math.floor(difference / 86400)
			return tostring(days) .. "d ago"
		end
	end
	notifbox_add_expired(n)
end)

return notifbox_layout
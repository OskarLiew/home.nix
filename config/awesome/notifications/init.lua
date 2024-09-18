local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require("menubar")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi

local get_notif_template = require("notifications.template")

naughty.config.icon_formats = { "svg", "png", "jpg", "gif" }

-- XDG icon lookup
naughty.connect_signal("request::icon", function(n, context, hints)
	if context ~= "app_icon" then
		return
	end

	local path = menubar.utils.lookup_icon(hints.app_icon) or menubar.utils.lookup_icon(hints.app_icon:lower())

	if path then
		n.icon = path
	end
end)

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		message = message,
	})
end)
-- }}}

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

	-- Low urgency apps
	ruled.notification.append_rule({
		rule_any = { app_name = {
			"Spotify",
			"Flameshot",
		} },
		properties = { urgency = "low" },
	})

	-- Normal urgency apps
	ruled.notification.append_rule({
		rule_any = { app_name = {
			"Discord",
			"Slack",
		} },
		properties = { urgency = "normal" },
	})

	ruled.notification.append_rule({
		rule = { urgency = "critical" },
		properties = { bg = beautiful.notification_bg_urgent, fg = beautiful.fg_normal },
	})
end)

naughty.connect_signal("request::display", function(n)
	return naughty.layout.box({
		notification = n,
		widget_template = {
			{
				{
					get_notif_template(n),
					widget = wibox.container.margin,
					margins = dpi(12),
				},
				widget = naughty.container.background,
				id = "backgorund_role",
			},
			widget = wibox.container.constraint,
			strategy = "exact",
		},
	})
end)

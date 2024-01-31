local wibox = require("wibox")

local function init_systray(base_size)
	local visible_entries, _ = awesome.systray()
	local systray = wibox.widget({
		visible = visible_entries > 0,
		base_size = base_size,
		horizontal = true,
		screen = "primary",
		widget = wibox.widget.systray,
	})

	systray:connect_signal("widget::layout_changed", function()
		-- hide systray if there are no visible entries
		visible_entries, _ = awesome.systray()
		systray.visible = visible_entries > 0
	end)
	return systray
end

return init_systray

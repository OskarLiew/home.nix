local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local clickable_container = require("widget.clickable-container")
local icons = beautiful.icons.hardware

local bar_kinds = {
	cpu = {
		bg = beautiful.bg_blue,
		fg = beautiful.blue,
		image = "cpu",
		daemon = "daemon::cpu-usage",
		tooltip = "CPU usage: %.1f%%",
	},
	ram = {
		bg = beautiful.bg_green,
		fg = beautiful.green,
		image = "memory",
		daemon = "daemon::ram-usage",
		tooltip = "RAM usage: %.1f%%",
	},
	temp = {
		bg = beautiful.bg_red,
		fg = beautiful.red,
		image = "thermometer",
		daemon = "daemon::cpu-temp",
		tooltip = "CPU temperature: %.1f°C",
	},
}

local function init_hardware_bar(kind)
	local kind_data = bar_kinds[kind]

	local bar = wibox.widget({
		widget = wibox.widget.progressbar,
		shape = gears.shape.rounded_rect,
		background_color = kind_data.bg,
		color = kind_data.fg,
		margins = dpi(10),
		value = 0,
		max_value = 100,
	})

	awesome.connect_signal(kind_data.daemon, function(value)
		bar.value = value
	end)

	local icon = wibox.widget({
		{
			widget = wibox.widget.imagebox,
			image = icons[kind_data.image],
			resize = true,
		},
		widget = clickable_container,
	})

	local widget = wibox.widget({
		{
			icon,
			bar,
			spacing = dpi(12),
			layout = wibox.layout.fixed.horizontal,
			forced_height = dpi(32),
		},
		margins = 4,
		widget = wibox.container.margin,
	})

	local tooltip = awful.tooltip({
		objects = { widget },
		text = "None",
		align = "right",
		margin_leftright = dpi(8),
		margin_topbottom = dpi(8),
		bg = beautiful.bg_popup,
	})

	widget:connect_signal("mouse::enter", function()
		tooltip:set_text(string.format(kind_data.tooltip, bar.value))
	end)

	return widget
end

return init_hardware_bar

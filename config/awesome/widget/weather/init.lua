local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local function init_weather_widget(config)
	local current_weather = require("widget.weather.current")(config)
	local forecast = require("widget.weather.forecast")(config)
	local widget = wibox.widget({
		current_weather,
		forecast,
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(15),
	})
	return widget
end

return init_weather_widget

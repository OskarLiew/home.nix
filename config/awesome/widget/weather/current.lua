local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local naughty = require("naughty")

local json = require("cjson")
local icons = beautiful.icons.weather

local weather_helpers = require("widget.weather.common")

local function init_weather_widget(config)
	local current_weather_desc = wibox.widget({
		text = "No data",
		font = "Inter 20",
		align = "center",
		widget = wibox.widget.textbox,
	})

	local current_weather_icon = weather_helpers.init_weather_imagebox(dpi(52))

	local current_weather_temp = wibox.widget({
		text = "",
		font = "Inter 20",
		align = "left",
		widget = wibox.widget.textbox,
	})

	local current_weather_cmd = [[sh -c "curl 'http://api.openweathermap.org/data/2.5/weather?q=]]
		.. weather_helpers.config.location
		.. [[&APPID=]]
		.. weather_helpers.token
		.. [['"]]

	awful.widget.watch(current_weather_cmd, 60 * 15, function(widget, stdout, stderr, exitreason, exitcode)
		if exitcode == 0 then
			local current_weather_data = json.decode(stdout)
			if current_weather_data.cod == 200 then
				current_weather_temp.text = weather_helpers.convert_temp(current_weather_data.main.temp)
				current_weather_desc.text = current_weather_data.weather[1].description:gsub("^%l", string.upper)
				current_weather_icon.image = weather_helpers.get_weather_icon(current_weather_data.weather[1].icon)
			else
				current_weather_icon.image = icons.error
				current_weather_desc.text = "Error"
				naughty.notification({
					app_name = "Weather",
					title = "Error in the weather widget",
					message = current_weather_data.message,
					urgency = "critical",
				})
			end
		else
			current_weather_icon.image = icons.error
			current_weather_desc.text = "Error fetching weather data"
		end
	end)

	local current_weather = wibox.widget({
		current_weather_desc,
		{
			{
				current_weather_icon,
				current_weather_temp,
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(20),
			},
			widget = wibox.container.place,
			halign = "center",
		},
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(10),
	})

	local weather_widget = wibox.widget({
		current_weather,
		layout = wibox.layout.fixed.vertical,
	})

	return weather_widget
end

return init_weather_widget

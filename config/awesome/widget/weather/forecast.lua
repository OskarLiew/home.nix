local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local json = require("cjson")

local weather_helpers = require("widget.weather.common")

local function init_forecast_subwidget(time, temp, icon_code)
	local temp_textbox = wibox.widget({
		text = time,
		font = "Inter 14",
		align = "center",
		widget = wibox.widget.textbox,
	})

	local time_textbox = wibox.widget({
		text = weather_helpers.convert_temp(temp),
		font = "Inter 14",
		align = "center",
		widget = wibox.widget.textbox,
	})

	local icon_imagebox = weather_helpers.init_weather_imagebox(dpi(32))
	icon_imagebox.image = weather_helpers.get_weather_icon(icon_code)

	local widget = wibox.widget({
		{
			temp_textbox,
			icon_imagebox,
			time_textbox,
			layout = wibox.layout.fixed.vertical,
			spacing = dpi(2),
		},
		widget = wibox.container.place,
		halign = "center",
	})

	return widget
end

local function init_forecast_widget(config)
	local n_times = config.forecasts or 5
	local layout = wibox.widget({
		layout = wibox.layout.grid,
		homogenous = true,
		forced_num_cols = n_times,
		forced_num_rows = 1,
		expand = true,
	})

	local forecast_cmd = [[sh -c "curl 'http://api.openweathermap.org/data/2.5/forecast?q=]]
		.. weather_helpers.config.location
		.. [[&APPID=]]
		.. weather_helpers.token
		.. [['"]]

	awful.widget.watch(forecast_cmd, 60 * 60, function(widget, stdout, stderr, exitreason, exitcode)
		layout:reset()
		if exitcode == 0 then
			local forecast_data = json.decode(stdout)
			if forecast_data.cod == "200" then
				for i = 1, n_times do
					local weather = forecast_data.list[i]
					layout:add(
						init_forecast_subwidget(weather.dt_txt:sub(12, 13), weather.main.temp, weather.weather[1].icon)
					)
				end
			end
		end
	end)

	return layout
end

return init_forecast_widget

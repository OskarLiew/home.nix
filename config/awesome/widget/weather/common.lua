local beautiful = require("beautiful")
local naughty = require("naughty")

local init_icon = require("helpers.icon").init_icon
local read_file = require("helpers.io").read_file

local config = require("configuration.widget").weather
local token = read_file(config.api_key_path)
if token == nil then
	naughty.notification({
		app_name = "Weather",
		title = "Error in the weather widget",
		message = "API key path at " .. config.api_key_path .. " not found.",
		urgency = "critical",
	})
	token = ""
else
	token = token:gsub("\n", "")
end

local icons = beautiful.icons.weather

local function convert_temp(degrees_k)
	local degrees_c = tonumber(degrees_k) - 273.15
	return string.format("%.0f", degrees_c) .. "°"
end

local function get_weather_icon(icon_code)
	local mapping = {
		["01d"] = icons.sun,
		["01n"] = icons.moon,
		["02d"] = icons.sunny,
		["02n"] = icons.cloudy,
		["03d"] = icons.cloudy,
		["03n"] = icons.cloudy,
		["04d"] = icons.cloud,
		["04n"] = icons.cloud,
		["09d"] = icons.light,
		["09n"] = icons.light,
		["10d"] = icons.heavy_rain,
		["10n"] = icons.heavy_rain,
		["11d"] = icons.thunderstorm,
		["11n"] = icons.thunderstorm,
		["13d"] = icons.snow,
		["13n"] = icons.snow,
		["50d"] = icons.fog,
		["50n"] = icons.fog,
	}
	return mapping[icon_code]
end

local function init_weather_imagebox(size)
	local icon_stylesheet = ""
		.. ".sun { stroke:"
		.. beautiful.yellow
		.. "; fill:"
		.. beautiful.yellow
		.. ";} "
		.. ".moon { stroke:"
		.. beautiful.blue
		.. "; fill:"
		.. beautiful.blue
		.. ";} "
		.. ".cloud { stroke:"
		.. beautiful.fg
		.. ";}"
		.. ".cloud-dark { stroke:"
		.. beautiful.gray2
		.. ";}"
		.. ".lightning { stroke:"
		.. beautiful.yellow
		.. ";}"
		.. ".fog { stroke:"
		.. beautiful.blue
		.. ";}"
		.. ".snow { stroke:"
		.. beautiful.blue
		.. ";}"
		.. ".rain {stroke:"
		.. beautiful.blue
		.. ";}"
		.. ".error {stroke:"
		.. beautiful.red
		.. ";}"
	local weather_icon = init_icon(icons.error, size)
	weather_icon.stylesheet = icon_stylesheet
	return weather_icon
end

return {
	init_weather_imagebox = init_weather_imagebox,
	get_weather_icon = get_weather_icon,
	convert_temp = convert_temp,
	token = token,
	config = config,
}

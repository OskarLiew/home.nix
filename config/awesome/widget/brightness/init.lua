local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local recolor_image = require("helpers.icon").recolor_image
local slider = require("widget.slider-popup")

local icons = beautiful.icons.misc

local function get_icon(brightness_scaled)
	local icon = icons.brightness
	if brightness_scaled < 0.33 then
		icon = icons.brightness_low
	elseif brightness_scaled > 0.66 then
		icon = icons.brightness_high
	end
	return recolor_image(icon, beautiful.fg)
end

local brightness_imagebox = wibox.widget({
	nil,
	{
		id = "icon",
		image = icons.brightness,
		widget = wibox.widget.imagebox,
		resize = true,
	},
	nil,
	expland = "none",
	layout = wibox.layout.align.vertical,
})

local brightness_slider = slider({
	imagebox = brightness_imagebox,
})

-- Functionality

local function update_brightness()
	-- Sleep to avoid race condition
	awful.spawn.easy_async_with_shell("sleep 0.01 && xbacklight -get", function(stdout)
		stdout = stdout:gsub("\n", "")
		local brightness_percentage = tonumber(stdout)

		-- Stop if null
		if not brightness_percentage then
			return
		end
		local brightness_scaled = math.log(brightness_percentage) / math.log(100)

		brightness_slider.set_value(brightness_scaled * 100)

		-- Set icon
		local icon = get_icon(brightness_scaled)
		brightness_imagebox.icon:set_image(gears.surface.load_uncached(icon))

		-- make volume_adjust component visible
		brightness_slider.display()
	end)
end

-- Trigger events
awesome.connect_signal("backlight_change", update_brightness)

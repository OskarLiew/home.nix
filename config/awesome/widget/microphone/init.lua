local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi

local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. "widget/microphone/icons/"

local function init_mic_widget()
	local image = gears.color.recolor_image(widget_icon_dir .. "microphone-mute.svg", beautiful.fg)

	local mic_imagebox = wibox.widget({
		nil,
		{
			id = "icon",
			image = image,
			widget = wibox.widget.imagebox,
			resize = true,
		},
		nil,
		expland = "none",
		layout = wibox.layout.align.vertical,
	})

	local mic_widget = wibox.widget({
		mic_imagebox,
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(0),
		visible = false,
	})

	-- Functionality
	local function update_mic()
		awful.spawn.easy_async_with_shell(
			-- Sleep to avoid race condition
			[[sleep 0.05 && awk '/Left:/ { print $NF }' <(amixer sget Capture)]],
			function(stdout)
				stdout = stdout:gsub("\n", "")
				local muted = stdout == "[off]"

				if muted then
					mic_widget.visible = true
				else
					mic_widget.visible = false
				end
			end
		)
	end

	-- Trigger events
	awesome.connect_signal("mic-mute", update_mic)

	update_mic()

	return mic_widget
end

return init_mic_widget

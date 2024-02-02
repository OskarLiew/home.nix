local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi

local apps = require("configuration.apps")
local slider = require("widget.slider-popup")
local clickable_container = require("widget.clickable-container")
local recolor_image = require("helpers.icon").recolor_image

local icons = beautiful.icons.audio

local function get_icon(muted)
	local icon_name = "mic"
	if muted then
		icon_name = icon_name .. "_mute"
	end
	return recolor_image(icons[icon_name], beautiful.fg)
end

local function init_mic_widget()
	local mic_imagebox = wibox.widget({
		nil,
		{
			id = "icon",
			image = get_icon(true),
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
	})

	local mic_button = wibox.widget({
		mic_widget,
		widget = clickable_container,
		visible = false,
	})

	mic_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
		awful.spawn(apps.default.volume_mixer, false)
	end)))

	local mic_slider = slider({
		imagebox = mic_imagebox,
	})

	-- Functionality
	local function update_mic()
		awful.spawn.easy_async_with_shell(
			-- Sleep to avoid race condition
			[[sleep 0.05 && awk '/Left:/ { print $NF }' <(amixer sget Capture)]],
			function(stdout)
				stdout = stdout:gsub("\n", "")
				local muted = stdout == "[off]"

				local icon = get_icon(muted)
				mic_imagebox.icon:set_image(gears.surface.load_uncached(icon))
				mic_button.visible = muted

				-- Set volume
				awful.spawn.easy_async_with_shell(
					[[awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Capture) | tr -d '\n%']],
					function(stdout)
						local volume_percentage = tonumber(stdout)

						-- Stop if null
						if not volume_percentage then
							return
						end

						mic_slider.set_value(volume_percentage)
					end
				)
			end
		)
	end

	-- Trigger events
	awesome.connect_signal("mic-mute", update_mic)
	awesome.connect_signal("mic-mute", mic_slider.display)

	update_mic()

	return mic_button
end

return init_mic_widget

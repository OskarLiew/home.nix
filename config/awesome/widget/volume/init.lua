local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local apps = require("configuration.apps")
local slider = require("widget.slider-popup")
local clickable_container = require("widget.clickable-container")

local icons = beautiful.icons.audio

local function return_button()
	local volume_imagebox = wibox.widget({
		nil,
		{
			id = "icon",
			image = icons.volume_mute,
			widget = wibox.widget.imagebox,
			resize = true,
		},
		nil,
		expland = "none",
		layout = wibox.layout.align.vertical,
	})

	local volume_widget = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(0),
		volume_imagebox,
	})

	local volume_button = wibox.widget({
		volume_widget,
		widget = clickable_container,
	})

	volume_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
		awful.spawn(apps.default.volume_mixer, false)
	end)))

	local volume_tooltip = awful.tooltip({
		objects = { volume_button },
		text = "None",
		mode = "outside",
		align = "right",
		margin_leftright = dpi(8),
		margin_topbottom = dpi(8),
		preferred_positions = { "right", "left", "top", "bottom" },
	})

	local volume_slider = slider({
		imagebox = volume_imagebox,
	})

	-- Functionality

	local function update_volume(muted)
		awful.spawn.easy_async_with_shell(
			[[pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5 }' | tr -d '\n$']],
			function(stdout)
				local volume_percentage = tonumber(stdout:match("%d+"))

				-- Stop if null
				if not volume_percentage then
					return
				end

				volume_slider.set_value(volume_percentage)

				-- Update tooltip text
				local tooltip_text = volume_percentage .. "%"
				if muted then
					tooltip_text = "Muted (" .. tooltip_text .. ")"
				end
				volume_tooltip:set_text(tooltip_text)

				-- Set icon
				local icon_name = "volume"

				if muted then
					icon_name = icon_name .. "_mute"
				elseif volume_percentage < 50 then
					icon_name = icon_name .. "_small"
				else
					icon_name = icon_name .. "_notice"
				end
				volume_imagebox.icon:set_image(gears.surface.load_uncached(icons[icon_name]))
			end
		)
	end

	local function set_volume()
		awful.spawn.easy_async_with_shell(
			-- Sleep to avoid race condition
			[[sleep 0.01 && pactl get-sink-mute @DEFAULT_SINK@ | awk ' { print $2 }']],
			function(stdout)
				local muted = stdout:gsub("%s+", "") == "yes"

				update_volume(muted)
			end
		)
	end

	-- Trigger events
	awesome.connect_signal("volume-change", set_volume)
	awesome.connect_signal("volume-change", volume_slider.display)

	set_volume()
	return volume_button
end

return return_button

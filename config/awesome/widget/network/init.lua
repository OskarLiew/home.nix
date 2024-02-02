local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local apps = require("configuration.apps")
local clickable_container = require("widget.clickable-container")

local icons = beautiful.icons.network

local function return_button(wireless_interface)
	local network_imagebox = wibox.widget({
		nil,
		{
			id = "icon",
			image = icons.wifi,
			widget = wibox.widget.imagebox,
			resize = true,
		},
		nil,
		expland = "none",
		layout = wibox.layout.align.vertical,
	})

	local network_widget = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(0),
		network_imagebox,
	})

	local network_button = wibox.widget({
		network_widget,
		widget = clickable_container,
	})

	network_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
		awful.spawn(apps.default.network_manager, false)
	end)))

	local network_tooltip = awful.tooltip({
		objects = { network_button },
		text = "None",
		mode = "outside",
		align = "right",
		margin_leftright = dpi(8),
		margin_topbottom = dpi(8),
		preferred_positions = { "right", "left", "top", "bottom" },
	})

	local get_network_info = function()
		awful.spawn.easy_async_with_shell("iwconfig " .. wireless_interface, function(stdout)
			if stdout == nil or stdout == "" then
				network_tooltip:set_text("iwconfig error with interface " .. wireless_interface)
				return
			end

			-- Remove new line from the last line
			network_tooltip:set_text(stdout:sub(1, -3))
		end)
	end
	get_network_info()

	network_widget:connect_signal("mouse::enter", function()
		get_network_info()
	end)

	local function update_network_strength(network_strength)
		-- Stop if null
		if not network_strength then
			return
		end

		network_widget.spacing = dpi(5)

		local icon = icons.wifi
		if network_strength < 0.33 then
			icon = icons.wifi_low
		elseif network_strength < 0.67 then
			icon = icons.wifi_mid
		else
			icon = icons.wifi_high
		end
		network_imagebox.icon:set_image(gears.surface.load_uncached(icon))
	end

	local function update_network_disconnected()
		network_widget.spacing = dpi(0)
		network_imagebox.icon:set_image(gears.surface.load_uncached(icons.wifi_disconnected))
	end

	awesome.connect_signal("daemon::network-strength", update_network_strength)
	awesome.connect_signal("daemon::network-connected", update_network_strength)
	awesome.connect_signal("daemon::network-disconnected", update_network_disconnected)

	return network_button
end

return return_button

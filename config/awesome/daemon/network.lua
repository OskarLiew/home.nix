local awful = require("awful")
local naughty = require("naughty")

local config = require("configuration.widget")

local beautiful = require("beautiful")
local icons = beautiful.icons.network

local function start_network_daemon(wireless_interface)
	local script = "iw dev " .. wireless_interface .. " link"

	local connected = false
	local show_disconnected_notification = function()
		naughty.notification({
			icon = icons.wifi_disconnected,
			app_name = "System",
			title = "Disconnection",
			message = "You have been disconnected from a network",
			urgency = "normal",
		})
	end

	local show_connected_notification = function()
		naughty.notification({
			icon = icons.wifi_high,
			app_name = "System",
			title = "Connection",
			message = "You have been connected to a network",
			urgency = "normal",
		})
	end

	local function get_network_signal_and_emit()
		local cmd = "iwconfig " .. wireless_interface .. [[ | awk '/Link Quality=/ {print $2}' | tr -d 'Quality=']]
		awful.spawn.easy_async_with_shell(cmd, function(stdout)
			stdout = stdout:gsub("\n", "")
			local numer, denom = stdout:match("([^,]+)/([^,]+)")
			local network_strength = tonumber(numer) / tonumber(denom)

			awful.emit_signal("daemon::network", network_strength)
		end)
	end

	local refresh_rate = 5 -- In seconds
	awful.widget.watch(script, refresh_rate, function(widget, stdout)
		-- Disconnected
		local connected_tmp = false
		if string.find(stdout, "^Connected") then
			connected_tmp = true
			get_network_signal_and_emit()
		end

		if connected and not connected_tmp then
			show_disconnected_notification()
			awful.emit_signal("daemon::network-connected")
		elseif not connected and connected_tmp then
			show_connected_notification()
			awful.emit_signal("daemon::network-disconnected")
		end
		connected = connected_tmp
	end)
end

return start_network_daemon(config.network.wireless_interface)

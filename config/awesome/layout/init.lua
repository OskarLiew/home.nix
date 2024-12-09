local awful = require("awful")
local ruled = require("ruled")

require("layout.titlebar")
require("layout.mymainmenu")

local top_panel = require("layout.top-panel")

screen.connect_signal("request::desktop_decoration", function(s)
	s.top_panel = top_panel(s)
	s.info_center = require("layout.info-center")(s)
end)

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
	-- All clients will match this rule.
	ruled.client.append_rule({
		id = "global",
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			titlebar = true,
		},
	})

	-- Floating clients.
	ruled.client.append_rule({
		id = "floating",
		rule_any = {
			instance = { "copyq", "pinentry" },
			class = {
				"Arandr",
				"Blueman-manager",
				"pavucontrol",
				"Gpick",
				"Kruler",
				"Sxiv",
				"Tor Browser",
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = {
			floating = true,
			placement = awful.placement.centered + awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	})

	-- Clients that should be floating in a small window
	ruled.client.append_rule({
		id = "floating-small",
		rule_every = {
			class = {
				"Nautilus",
				".blueman-manager-wrapped",
				"Pavucontrol",
				".arandr-wrapped",
				"SimpleScreenRecorder",
				"jagexlauncher.exe",
			},
		},
		properties = {
			floating = true,
			placement = awful.placement.centered + awful.placement.no_overlap + awful.placement.no_offscreen,
			width = 1200,
			height = 700,
		},
	})

	-- Clients that should never have titlebar
	ruled.client.append_rule({
		id = "no-titlebar",
		rule_every = {
			class = {
				"Nautilus",
			},
		},
		properties = {
			titlebar = false,
		},
	})

	-- Center floating
	ruled.client.append_rule({
		id = "floating-location",
		rule_any = {
			floating = true,
		},
		properties = {
			placement = awful.placement.centered + awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	})
end)
-- }}}

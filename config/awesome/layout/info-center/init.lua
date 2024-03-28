local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local icons = require("theme.icons")
local init_icon = require("helpers.icon").init_icon

local function init_info_panel(s)
	local function init_sub_panel(widget, fill)
		local sub_panel_shape = function(cr, width, height)
			return gears.shape.rounded_rect(cr, width, height, 2 * beautiful.edge_radius)
		end

		if not fill then
			widget = {
				widget,
				widget = wibox.container.place,
				content_fill_horizontal = true,
			}
		end

		return wibox.widget({
			{
				widget,
				widget = wibox.container.margin,
				margins = dpi(12),
			},
			widget = wibox.container.background,
			bg = beautiful.bg0 .. beautiful.bg_opacity,
			shape = sub_panel_shape,
		})
	end

	-- Create panel
	local panel_width = s.geometry.width * 3 / 5
	local panel_height = s.geometry.height * 3 / 4
	local panel = wibox({
		visible = false,
		ontop = true,
		type = "dock", -- Deactivates opacity for bg
		height = panel_height,
		width = panel_width,
		x = s.geometry.x + (s.geometry.width - panel_width) / 2,
		y = s.geometry.y + (s.geometry.height - panel_height) / 2,
		stretch = false,
		bg = beautiful.transparent,
	})

	-- Initialize widgets
	local big_clock = wibox.widget({
		{
			layout = wibox.layout.fixed.vertical,
			{
				format = "%H:%M",
				align = "center",
				font = "Inter 88",
				widget = wibox.widget.textclock,
			},
			{
				format = "%A, %B %d",
				align = "center",
				font = "Inter 24",
				widget = wibox.widget.textclock,
			},
		},
		top = dpi(10),
		widget = wibox.container.margin,
	})

	local hardware = wibox.widget({
		require("widget.hardware-bar")("temp"),
		require("widget.hardware-bar")("ram"),
		require("widget.hardware-bar")("cpu"),
		widget = wibox.layout.fixed.vertical,
	})

	local weather = require("widget.weather")()

	local uptime_textbox = wibox.widget({
		text = "uptime...",
		widget = wibox.widget.textbox,
		halign = "center",
		font = "Inter 16",
	})
	awesome.connect_signal("daemon::uptime", function(uptime)
		uptime_textbox.text = uptime
	end)
	local power_button = {
		init_icon(icons.misc.time, dpi(32), beautiful.fg),
		{
			uptime_textbox,
			widget = wibox.container.margin,
			left = dpi(12),
			forced_height = dpi(32),
		},
		nil,
		layout = wibox.layout.align.horizontal,
		spacing = dpi(12),
	}

	local music_player = require("widget.music-player")(true)
	local calendar = require("widget.calendar")(10)

	local notif_center = require("widget.notif-center")()

	-- Place widgets
	local col1_width = 5
	local col2_width = 4
	local col3_width = 5

	local n_rows = 20

	local l = wibox.widget({
		homogeneous = true,
		spacing = dpi(12),
		forced_num_rows = n_rows,
		forced_num_cols = col1_width + col2_width + col3_width,
		expand = true,
		layout = wibox.layout.grid,
	})

	-- row-idx, col-idx, row-span, col-span
	l:add_widget_at(init_sub_panel(big_clock), 1, 1, 6, col1_width)
	l:add_widget_at(init_sub_panel(hardware), 7, 1, 5, col1_width)
	l:add_widget_at(init_sub_panel(weather), 12, 1, 7, col1_width)
	l:add_widget_at(init_sub_panel(power_button), 19, 1, 2, col1_width)

	l:add_widget_at(init_sub_panel(music_player), 1, col1_width + 1, 12, col2_width)
	l:add_widget_at(init_sub_panel(calendar), 13, col1_width + 1, 8, col2_width)

	l:add_widget_at(init_sub_panel(notif_center, true), 1, col1_width + col2_width + 1, n_rows, col3_width)

	panel:setup({
		l,
		widget = wibox.container.margin,
	})

	panel.toggle = function(self)
		self.visible = not self.visible
	end

	return panel
end

return init_info_panel

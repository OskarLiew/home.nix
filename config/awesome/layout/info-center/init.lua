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

		widget = {
			widget,
			widget = wibox.container.margin,
			margins = dpi(12),
		}

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
			bg = beautiful.bg0 .. "EE",
			shape = sub_panel_shape,
		})
	end

	-- Create panel
	local width_ratio = 5 / 7
	local height_ratio = 3 / 4
	local panel_width = math.min(s.geometry.width * width_ratio, dpi(1920) * width_ratio)
	local panel_height = math.min(s.geometry.height * height_ratio, dpi(1080) * height_ratio)

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

	local uptime_textbox = wibox.widget({
		text = "uptime...",
		widget = wibox.widget.textbox,
		halign = "center",
		font = "Inter 16",
	})
	awesome.connect_signal("daemon::uptime", function(uptime)
		uptime_textbox.text = uptime
	end)
	local uptime_widget = {
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

	local n_rows = 80
	local col_widths = { 5, 4, 5 }
	local l = wibox.widget({
		homogeneous = true,
		spacing = dpi(12),
		forced_num_rows = n_rows,
		forced_num_cols = 14,
		expand = true,
		layout = wibox.layout.grid,
	})

	local widgets = {
		{
			{ big_clock, 22 },
			{ hardware, 15 },
			{ require("widget.weather")({ forecasts = 6 }), 24 },
			{ uptime_widget, 9 },
		},
		{
			{ require("widget.music-player")(true), 43 },
			{ require("widget.calendar")(12), 37 },
		},
		{
			{ require("widget.notif-center")(), n_rows, true },
		},
	}

	for col, cw in ipairs(widgets) do
		local y = 1
		for _, w in ipairs(cw) do
			local x = 1
			for i = 1, col do
				x = x + (col_widths[i - 1] or 0)
			end
			-- row-idx, col-idx, row-span, col-span
			l:add_widget_at(init_sub_panel(w[1], w[3]), y, x, w[2], col_widths[col])
			y = y + w[2]
		end
	end

	panel:setup({
		l,
		widget = wibox.container.margin,
	})

	panel.toggle = function(self)
		self.visible = not self.visible
		if self.visible then
			awesome.emit_signal("notif-center::opened")
		end
	end

	return panel
end

return init_info_panel

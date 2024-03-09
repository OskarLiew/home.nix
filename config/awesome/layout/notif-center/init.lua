local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local init_icon = require("helpers.icon").init_icon
local clickable_container = require("widget.clickable-container")

local function init_notification_center(s)
	local panel_shape = function(cr, width, height)
		return gears.shape.partially_rounded_rect(
			cr,
			width,
			height,
			true,
			false,
			false,
			true,
			2 * beautiful.edge_radius
		)
	end

	-- Create panel
	local panel_margins = dpi(12)
	local panel_width = dpi(beautiful.notification_max_width + 2 * panel_margins)
	local panel = wibox({
		visible = false,
		ontop = true,
		type = "normal",
		height = dpi(600),
		width = panel_width,
		x = s.geometry.x + s.geometry.width - panel_width,
		y = s.geometry.y + s.geometry.height - s.tiling_area.height + 2 * beautiful.useless_gap,
		shape = panel_shape,
		stretch = false,
		bg = beautiful.bg_dim .. beautiful.bg_opacity2,
		fg = beautiful.fg_normal,
	})

	-- Define widgets
	local title = wibox.widget({
		{
			widget = wibox.widget.textbox,
			text = "Notification center",
			font = beautiful.base_font .. ", bold 20",
			align = "center",
		},
		widget = wibox.container.margin,
		bottom = dpi(6),
	})

	local notif_list = require("layout.notif-center.notif-list")
	local notifications = wibox.widget({
		notif_list,
		widget = wibox.container.margin,
		top = dpi(6),
		bottom = dpi(6),
	})

	local clear_button = wibox.widget({
		{
			{
				{
					{
						{
							widget = wibox.widget.textbox,
							text = "Clear notifications",
							font = beautiful.base_font .. " 12",
						},
						init_icon(beautiful.icons.misc.delete, dpi(20), beautiful.fg),
						layout = wibox.layout.fixed.horizontal,
						spacing = dpi(12),
					},
					widget = wibox.container.place,
				},
				widget = wibox.container.background,
				bg = beautiful.bg_red,
				forced_height = dpi(36),
				shape = function(cr, w, h)
					gears.shape.rounded_rect(cr, w, h, dpi(18))
				end,
			},
			widget = clickable_container,
		},
		widget = wibox.container.margin,
		left = dpi(24),
		right = dpi(24),
	})
	clear_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
		notif_list:reset()
	end)))

	panel:setup({
		{
			title,
			notifications,
			clear_button,
			layout = wibox.layout.align.vertical,
			fill_space = true,
			spacing = dpi(6),
		},
		margins = panel_margins,
		widget = wibox.container.margin,
	})

	panel.toggle = function()
		local turn_on = not panel.visible
		if turn_on then
			awesome.emit_signal("notif-center::opened")
		end
		panel.visible = turn_on
	end

	return panel
end

return init_notification_center

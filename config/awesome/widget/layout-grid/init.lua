local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local beautiful = require("beautiful")

local function layout_grid(args)
	args = args or {}
	local screen = awful.screen.focused()
	local container_height = args.height or dpi(216)
	local container_width = args.width or dpi(384)

	local container = wibox({
		screen = screen,
		x = screen.geometry.x + screen.geometry.width / 2 - container_width / 2,
		y = screen.geometry.y + screen.geometry.height / 2 - container_height / 2,
		width = container_width,
		height = container_height,
		shape = gears.shape.rounded_rect,
		visible = false,
		ontop = true,
		opacity = 0.5,
		bg = beautiful.bg_popup,
	})

	-- create a timer to hide the widget
	-- component whenever the timer is started
	local hide_adjust = gears.timer({
		timeout = 1,
		autostart = true,
		callback = function()
			container.visible = false
		end,
	})

	container.display = function()
		-- make adjust component visible
		if container.visible then
			hide_adjust:again()
		else
			container.visible = true
			hide_adjust:start()
		end
	end

	local function show_layout_grid()
		screen = awful.screen.focused()
		local tag = screen.selected_tag

		local function get_layoutbox(color)
			color = color or beautiful.green
			return {
				{
					widget = wibox.container.background,
					bg = color,
					shape = gears.shape.rounded_rect,
				},
				widget = wibox.container.margin,
				margins = dpi(10),
			}
		end

		-- Number of master clients
		local master_clients = {
			layout = wibox.layout.flex.vertical,
		}
		for _ = 1, tag.master_count do
			table.insert(master_clients, get_layoutbox())
		end

		-- Number of columns
		local columns = {
			layout = wibox.layout.flex.horizontal,
		}
		for _ = 1, tag.column_count do
			table.insert(columns, get_layoutbox())
		end

		container:setup({
			master_clients,
			columns,
			widget = wibox.container.margin,
			margins = dpi(20),
			layout = wibox.layout.ratio.horizontal,
			shape = gears.shape.rounded_rect,
		})

		-- Width of boxes
		local width = tag.master_width_factor
		if tag.master_count == 0 then
			width = 0
		end
		container.widget:set_ratio(1, width)

		-- Update screen and position
		container.screen = screen
		container.x = screen.geometry.x + screen.geometry.width / 2 - container_width / 2
		container.y = screen.geometry.y + screen.geometry.height / 2 - container_height / 2

		container.display()
	end
	awesome.connect_signal("layout_grid_change", show_layout_grid)

	return container
end

return layout_grid

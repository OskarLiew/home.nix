local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local function init_promptbox(args)
	args = args or {}
	local container_height = args.height or dpi(42)
	local container_width = args.width or dpi(256)

	local container = wibox({
		width = container_width,
		height = container_height,
		shape = gears.shape.rounded_rect,
		visible = false,
		ontop = true,
		opacity = 0.5,
		bg = beautiful.bg0,
		border_width = dpi(2),
		border_color = beautiful.green,
	})

	local promptbox = awful.widget.prompt({
		prompt = "❯ ",
		bg = beautiful.transparent,
		with_shell = true,
		done_callback = function()
			container.visible = false
		end,
	})

	container:setup({
		promptbox,
		widget = wibox.container.margin,
		margins = dpi(12),
	})

	container.run = function()
		-- Update screen and position
		screen = awful.screen.focused()
		container.screen = screen
		container.x = screen.geometry.x + screen.geometry.width / 2 - container_width / 2
		container.y = screen.geometry.y + screen.geometry.height * 0.15 - container_height / 2

		container.visible = true
		promptbox:run()
	end

	awesome.connect_signal("prompt::run", container.run)

	return promptbox
end

return init_promptbox

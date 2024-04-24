local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")

local clickable_container = require("widget.clickable-container")
local recolor_image = require("helpers.icon").recolor_image

local function get_notif_template(n)
	local action = {
		base_layout = wibox.widget({
			spacing = 12,
			layout = wibox.layout.fixed.horizontal,
		}),
		widget_template = {
			{
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					widget = wibox.container.margin,
					left = dpi(12),
					right = dpi(12),
					top = dpi(4),
					bottom = dpi(4),
				},
				widget = clickable_container,
			},
			shape = function(cr, w, h)
				gears.shape.rounded_rect(cr, w, h, dpi(4))
			end,
			bg = beautiful.notification_action_bg_normal,
			widget = wibox.container.background,
		},
		widget = naughty.list.actions,
	}

	local template = wibox.widget({
		{
			{
				widget = wibox.widget.imagebox,
				image = n.icon or recolor_image(beautiful.icons.misc.announce, beautiful.fg),
				resize = true,
				clip_shape = function(cr, w, h)
					gears.shape.rounded_rect(cr, w, h, dpi(6))
				end,
			},
			widget = wibox.container.constraint,
			width = dpi(42),
			strategy = "max",
		},
		{
			{
				{
					font = beautiful.notification_font or "Sans 12",
					markup = "<b>" .. n.title .. "</b>",
					widget = wibox.widget.textbox,
				},
				{
					markup = n.message,
					widget = wibox.widget.textbox,
				},
				widget = wibox.layout.fixed.vertical,
				spacing = dpi(6),
			},
			{
				widget = wibox.container.margin,
				top = dpi(12),
				visible = n.actions and #n.actions > 0,
			},
			action,
			widget = wibox.layout.fixed.vertical,
		},
		widget = wibox.layout.fixed.horizontal,
		spacing = dpi(12),
	})

	template:buttons(gears.table.join(awful.button({}, 1, nil, function()
		if #n.clients > 0 then
			n.clients[1]:jump_to(true)
		end
	end)))

	return template
end

return get_notif_template

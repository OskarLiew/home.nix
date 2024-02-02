local gears = require("gears")
local wibox = require("wibox")

local recolor_image = gears.color.recolor_image

local function init_icon(image, size, color)
	if color then
		image = recolor_image(image, color)
	end
	return wibox.widget({
		image = image,
		forced_height = size,
		forced_width = size,
		widget = wibox.widget.imagebox,
		valign = "center",
		halign = "center",
	})
end

return {
	init_icon = init_icon,
	recolor_image = recolor_image,
}

local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")

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

local function fetch_image(url, callback)
	-- Check if the url is already a cached file
	if url:sub(1, 7) == "file://" then
		local img = gears.surface.load_uncached(url:sub(8))
		if img then
			callback(img)
		else
			callback(nil)
		end
	end

	-- Generate a temporary file path to save the image
	local temp_filepath = os.getenv("XDG_CACHE_HOME") .. "/awesome/temp_image.jpg"

	-- Download the image using wget
	awful.spawn.easy_async_with_shell("wget -q -O " .. temp_filepath .. " " .. url, function(exit_code)
		local img = gears.surface.load_uncached(temp_filepath)
		if img then
			callback(img)
		else
			callback(nil)
		end
		os.remove(temp_filepath)
	end)
end

return {
	init_icon = init_icon,
	recolor_image = recolor_image,
	fetch_image = fetch_image,
}

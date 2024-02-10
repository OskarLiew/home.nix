---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gears = require("gears")
local recolor_image = gears.color.recolor_image
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")

local themes_path = gfs.get_themes_dir()
local icons = require("theme.icons")

local theme = {}

theme.icons = icons

theme.base_font = "sans"
theme.base_font_size = "10"
theme.font = theme.base_font .. " " .. theme.base_font_size

theme.bg_opacity = "CC"
theme.bg_opacity2 = "70"
theme.fg_opacity = "CC"

-- Everforest colours
theme.bg_dim = "#1E2326"
theme.bg0 = "#272E33"
theme.bg1 = "#2E383C"
theme.bg2 = "#374145"
theme.bg3 = "#414B50"
theme.bg4 = "#495156"
theme.bg5 = "#4F5B58"

theme.bg_red = "#4C3743"
theme.bg_visual = "#493B40"
theme.bg_yellow = "#45443C"
theme.bg_green = "#3C4841"
theme.bg_blue = "#384B55"

theme.red = "#E67E80"
theme.orange = "#E69875"
theme.yellow = "#DBBC7F"
theme.green = "#A7C080"
theme.blue = "#7FBBB3"
theme.aqua = "#83C092"
theme.purple = "#D699B6"

theme.fg = "#D3C6AA"
theme.statusline1 = theme.green
theme.statusline2 = theme.fg
theme.statusline3 = theme.red
theme.gray0 = "#7A8478"
theme.gray1 = "#859289"
theme.gray2 = "#9DA9A0"

theme.transparent = "#00000000"

-- Apply colors
theme.bg_normal = theme.bg0
theme.bg_focus = theme.green
theme.bg_urgent = theme.red
theme.bg_popup = theme.bg3

theme.fg_normal = theme.fg
theme.fg_focus = theme.bg_green
theme.fg_urgent = theme.bg_red
theme.fg_inactive = theme.gray0

theme.useless_gap = dpi(6)
theme.border_width = dpi(0)
theme.border_color_normal = theme.bg_dim
theme.border_color_active = theme.bg_blue
theme.border_color_marked = theme.bg_visual

theme.edge_radius = dpi(18)

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

--Tooltip
theme.tooltip_bg = theme.bg_popup
theme.tooltip_fg = theme.fg_normal

-- Hotkeys
theme.hotkeys_bg = theme.bg_normal .. theme.bg_opacity
theme.hotkeys_modifiers_fg = theme.bg_focus

-- Notifications
-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_max_width = dpi(420)
theme.notification_bg = theme.bg1 .. theme.bg_opacity2
theme.notification_bg_urgent = theme.bg_red .. theme.bg_opacity2
theme.notification_fg = theme.fg_normal
theme.notification_border_color = theme.bg2 .. theme.bg_opacity2
theme.notification_border_width = 0 -- There is still a tiny border
theme.notification_action_bg_normal = theme.bg_popup
theme.notification_action_underline_normal = false
theme.notification_spacing = dpi(6)
theme.notification_shape = function(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, theme.edge_radius)
end

-- Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)
theme.menu_bg_normal = theme.bg_popup .. theme.bg_opacity

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Titlebar
theme.titlebar_fg_normal = theme.fg_inactive
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg
theme.titlebar_bg_focus = theme.bg_normal
theme.titlebar_fg_urgent = theme.bg_urgent
theme.titlebar_bg_urgent = theme.fg_urgent

theme.titlebar_color_close_bg = theme.red
theme.titlebar_color_close_fg = theme.bg_red
theme.titlebar_color_on_top_bg = theme.yellow
theme.titlebar_color_on_top_fg = theme.bg_yellow
theme.titlebar_color_max_bg = theme.green
theme.titlebar_color_max_fg = theme.bg_green
theme.titlebar_color_float_bg = theme.blue
theme.titlebar_color_float_fg = theme.bg_blue

-- Define the image to load

theme.titlebar_close_button_normal = recolor_image(icons.misc.close, theme.fg_inactive)
theme.titlebar_close_button_focus = recolor_image(icons.misc.close, theme.titlebar_color_close_fg)

theme.titlebar_ontop_button_normal_inactive = recolor_image(icons.titlebar.on_top, theme.fg_inactive)
theme.titlebar_ontop_button_focus_inactive = recolor_image(icons.titlebar.on_top, theme.titlebar_color_on_top_fg)
theme.titlebar_ontop_button_normal_active = recolor_image(icons.titlebar.not_on_top, theme.fg_inactive)
theme.titlebar_ontop_button_focus_active = recolor_image(icons.titlebar.not_on_top, theme.titlebar_color_on_top_fg)

theme.titlebar_maximized_button_normal_inactive = recolor_image(icons.titlebar.maximize, theme.fg_inactive)
theme.titlebar_maximized_button_focus_inactive = recolor_image(icons.titlebar.maximize, theme.titlebar_color_max_fg)
theme.titlebar_maximized_button_normal_active = recolor_image(icons.titlebar.unmaximize, theme.fg_inactive)
theme.titlebar_maximized_button_focus_active = recolor_image(icons.titlebar.unmaximize, theme.titlebar_color_max_fg)

theme.titlebar_floating_button_focus_inactive = recolor_image(icons.titlebar.floating, theme.titlebar_color_float_fg)
theme.titlebar_floating_button_normal_inactive = recolor_image(icons.titlebar.floating, theme.fg_inactive)
theme.titlebar_floating_button_normal_active = recolor_image(icons.titlebar.tiling, theme.fg_inactive)
theme.titlebar_floating_button_focus_active = recolor_image(icons.titlebar.tiling, theme.titlebar_color_float_fg)

theme.wallpaper = require("theme.wallpaper")

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Systray
theme.systray_icon_spacing = dpi(6)

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Change color of layoutbox
theme = theme_assets.recolor_layout(theme, theme.fg_normal)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

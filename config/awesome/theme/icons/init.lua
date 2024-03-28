-- Icons directory
local dir = os.getenv("HOME") .. "/.config/awesome/theme/icons/"

local icons = {

	-- Taglist
	taglist = {
		terminal = dir .. "taglist/terminal.svg",
		web_browser = dir .. "taglist/earth.svg",
		text_editor = dir .. "taglist/code.svg",
		notepad = dir .. "taglist/notebook.svg",
		file_manager = dir .. "taglist/folder-open.svg",
		multimedia = dir .. "taglist/playback-progress.svg",
		sandbox = dir .. "taglist/cube-four.svg",
		meeting = dir .. "taglist/people-top-card.svg",
		social = dir .. "taglist/communication.svg",
	},

	titlebar = {
		close = dir .. "titlebar/close.svg",
		on_top = dir .. "titlebar/on-top.svg",
		not_on_top = dir .. "titlebar/not-on-top.svg",
		maximize = dir .. "titlebar/maximize.svg",
		unmaximize = dir .. "titlebar/unmaximize.svg",
		floating = dir .. "titlebar/floating.svg",
		tiling = dir .. "titlebar/tiling.svg",
	},

	battery = {
		alert = dir .. "battery/battery-alert.svg",
		charging = dir .. "battery/battery-charging.svg",
		unknown = dir .. "battery/battery-unknown.svg",
		working_100 = dir .. "battery/battery-working-100.svg",
		working_15 = dir .. "battery/battery-working-15.svg",
		working_25 = dir .. "battery/battery-working-25.svg",
		working_40 = dir .. "battery/battery-working-40.svg",
		working_50 = dir .. "battery/battery-working-50.svg",
		working_65 = dir .. "battery/battery-working-65.svg",
		working_75 = dir .. "battery/battery-working-75.svg",
		working_90 = dir .. "battery/battery-working-90.svg",
		battery = dir .. "battery/battery.svg",
	},

	hardware = {
		cpu = dir .. "hardware/cpu.svg",
		memory = dir .. "hardware/data.svg",
		thermometer = dir .. "hardware/thermometer.svg",
	},

	audio = {
		next = dir .. "audio/next.svg",
		pause = dir .. "audio/pause.svg",
		play = dir .. "audio/play.svg",
		previous = dir .. "audio/previous.svg",
		music = dir .. "audio/music.svg",
		mic_mute = dir .. "audio/microphone-mute.svg",
		mic = dir .. "audio/microphone.svg",
		volume_up = dir .. "audio/volume-up.svg",
		volume_down = dir .. "audio/volume-down.svg",
		volume_mute = dir .. "audio/volume-mute.svg",
		volume_notice = dir .. "audio/volume-notice.svg",
		volume_small = dir .. "audio/volume-small.svg",
	},

	network = {
		ethernet_on = dir .. "network/ethernet-on.svg",
		wifi_disconnected = dir .. "network/wifi-disconnected.svg",
		wifi_high = dir .. "network/wifi-high.svg",
		wifi_low = dir .. "network/wifi-low.svg",
		wifi_mid = dir .. "network/wifi-mid.svg",
		wifi = dir .. "network/wifi.svg",
	},

	weather = {
		cloud_dark = dir .. "weather/cloud-dark.svg",
		cloud = dir .. "weather/cloud.svg",
		cloudy_night = dir .. "weather/cloudy-night.svg",
		cloudy = dir .. "weather/cloudy.svg",
		error = dir .. "weather/error.svg",
		fog_dark = dir .. "weather/fog-dark.svg",
		fog = dir .. "weather/fog.svg",
		heavy_rain_dark = dir .. "weather/heavy-rain-dark.svg",
		heavy_rain = dir .. "weather/heavy-rain.svg",
		light_rain_dark = dir .. "weather/light-rain-dark.svg",
		light_rain = dir .. "weather/light-rain.svg",
		moon = dir .. "weather/moon.svg",
		snow_dark = dir .. "weather/snow-dark.svg",
		snow = dir .. "weather/snow.svg",
		sun = dir .. "weather/sun.svg",
		sunny = dir .. "weather/sunny.svg",
		thunderstorm_dark = dir .. "weather/thunderstorm-dark.svg",
		thunderstorm = dir .. "weather/thunderstorm.svg",
	},

	misc = {
		keyboard = dir .. "misc/keyboard.svg",
		power = dir .. "misc/power.svg",
		brightness_high = dir .. "misc/brightness-high.svg",
		brightness_low = dir .. "misc/brightness-low.svg",
		brightness = dir .. "misc/brightness.svg",
		close = dir .. "misc/close.svg",
		close_small = dir .. "misc/close-small.svg",
		delete = dir .. "misc/delete.svg",
		announce = dir .. "misc/announcement.svg",
		left = dir .. "misc/left.svg",
		right = dir .. "misc/right.svg",
		time = dir .. "misc/time.svg",
	},
}

return icons

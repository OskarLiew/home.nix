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
		thermomenter = dir .. "hardware/thermometer.svg",
	},

	audio = {
		next = dir .. "audio/next.svg",
		pause = dir .. "audio/pause.svg",
		play = dir .. "audio/play.svg",
		previous = dir .. "audio/previous.svg",
		mic_mute = dir .. "audio/microphone-mute.svg",
		volume_up = dir .. "volume-up.svg",
		volume_down = dir .. "volume-down.svg",
		volume_mute = dir .. "volume-mute.svg",
		volume_notice = dir .. "volume-notice.svg",
		volume_small = dir .. "volume-small.svg",
	},

	network = {
		ethernet_on = "ethernet-on.svg",
		wifi_disconnected = "wifi-disconnected.svg",
		wifi_high = "wifi-high.svg",
		wifi_low = "wifi-low.svg",
		wifi_mid = "wifi-mid.svg",
		wifi = "wifi.svg",
	},

	weather = {
		cloud_dark = "weather/cloud-dark.svg",
		cloud = "weather/cloud.svg",
		cloudy_night = "weather/cloudy-night.svg",
		cloudy = "weather/cloudy.svg",
		error = "weather/error.svg",
		fog_dark = "weather/fog-dark.svg",
		fog = "weather/fog.svg",
		heavy_rain_dark = "weather/heavy-rain-dark.svg",
		heavy_rain = "weather/heavy-rain.svg",
		light_rain_dark = "weather/light-rain-dark.svg",
		light_rain = "weather/light-rain.svg",
		moon = "weather/moon.svg",
		snow_dark = "weather/snow-dark.svg",
		snow = "weather/snow.svg",
		sun = "weather/sun.svg",
		sunny = "weather/sunny.svg",
		thunderstorm_dark = "weather/thunderstorm-dark.svg",
		thunderstorm = "weather/thunderstorm.svg",
	},

	misc = {
		keyboard = dir .. "misc/keyboard.svg",
		power = dir .. "misc/power.svg",
		brightness_high = "misc/brightness-high.svg",
		brightness_low = "misc/brightness-low.svg",
		brightness = "misc/brightness.svg",
		close = dir .. "misc/close.svg",
		close_small = dir .. "misc/close-small.svg",
		delete = dir .. "misc/delete.svg",
	},

	-- Others/System UI
	logout = dir .. "logout.svg",
	sleep = dir .. "power-sleep.svg",
	power = dir .. "power.svg",
	lock = dir .. "lock.svg",
	restart = dir .. "restart.svg",
	search = dir .. "magnify.svg",
	volume = dir .. "volume-high.svg",
	brightness = dir .. "brightness-7.svg",
	effects = dir .. "effects.svg",
	chart = dir .. "chart-areaspline.svg",
	memory = dir .. "memory.svg",
	hard_drive = dir .. "hard-drive.svg",
	thermometer = dir .. "thermometer.svg",
	plus = dir .. "plus.svg",
	batt_charging = dir .. "battery-charge.svg",
	batt_discharging = dir .. "battery-discharge.svg",
	toggled_on = dir .. "toggled-on.svg",
	toggled_off = dir .. "toggled-off.svg",
}

return icons

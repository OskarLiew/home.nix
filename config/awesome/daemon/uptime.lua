local awful = require("awful")

local script = [[sh -c "uptime -p | sed -e 's/up //g'"]]

awful.widget.watch(script, 60, function(widget, stdout)
	stdout = stdout:gsub("\n", "")
	awesome.emit_signal("daemon::uptime", stdout)
end)

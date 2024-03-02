-- Initalize components
require("widget.brightness")
require("widget.layout-grid")()
require("widget.prompt")()

return {
	keys = require("configuration.keys"),
	apps = require("configuration.apps"),
}

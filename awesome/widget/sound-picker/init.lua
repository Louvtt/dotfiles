local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local element_class = require("widget.sound-picker.entities.element")
local dpi = beautiful.xresources.apply_dpi

local build = function(s)
	-- Set the panel geometry
	local panel_width = dpi(350)

	local container = wibox.layout.flex.vertical()
	local panel = awful.popup({
		widget = container,
		type = "dock",
		screen = s,
		visible = false,
		ontop = true,
		width = dpi(panel_width),
		maximum_width = dpi(panel_width),
	})

	-- top right safe
	awful.placement.top_right(panel, {
		honor_workarea = true,
		parent = s,
		margins = {
			top = dpi(33),
			right = dpi(5),
		},
	})

	local sinks = {}
	local update_sinks = function()
		awful.spawn.easy_async_with_shell(
			"pactl list sinks | awk '/Name/,/Description/'",
			function(stdout)
				for i,element in ipairs(sinks) do
					container:remove(element.widget)
				end
				sinks = {} -- clear

				for name_id,name in string.gmatch(stdout, 'Name: ([%w%p]+)\n%s+Description: ([%w%s%/]+) ') do
					local input_el = element_class:new(name_id, name, false)
					container:add(input_el.widget)
					table.insert(sinks, input_el)
				end
			end
		)
	end

	local sinks_updater = gears.timer {
		timeout = 5,
		autostart = true,
		call_now = true,
		callback = function()
			update_sinks()
		end
	}

	return panel
end


awesome.connect_signal("sound-picker::opened", function()
end)

awesome.connect_signal("sound-picker::closed", function()
end)


return build

local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local element_class = require("widget.sound-picker.entities.element")
local dpi = beautiful.xresources.apply_dpi

local build = function(s)
	-- Set the panel geometry
	local panel_width = dpi(350)

	local container = wibox.widget {
		width = panel_width,
		maximum_width = panel_width,
		spacing = dpi(10),
		layout = wibox.layout.fixed.vertical,
	}
	local panel = awful.popup {
		widget    = container,
		type      = 'dock',
		visible   = false,
		ontop     = true,
		-- placement = awful.placement.top_right,
		shape     = gears.shape.rounded_rect,
		bg        = beautiful.transparent,
	}

	local sinks = {}
	local update_sinks = function()
		awful.spawn.easy_async_with_shell(
			"pactl list sinks | awk '/Name/,/Description/'",
			function(stdout)
				container:reset()
				for name_id,name in string.gmatch(stdout, 'Name: ([%w%p]+)\n%s+Description: ([%w%s%/]+) ') do
					local input_el = element_class:new(name_id, name, false)
					container:add(input_el.widget)
					sinks[name_id] = input_el
				end

				awful.spawn.easy_async_with_shell(
					"pactl info | awk '/Default Sink/'",
					function (stdout_)
						local default_sink_id = string.match(stdout_, 'Default Sink: ([%w%p]+)')
						local selected_sink = sinks[default_sink_id]
						if selected_sink then
							selected_sink.bg = beautiful.system_cyan_light
							selected_sink.selected_bg = beautiful.system_cyan_dark
							selected_sink:deselect()
						end
					end
				)

				-- top right safe
				local focused = awful.screen.focused()
				awful.placement.top_right(
					panel,
					{
						screen = focused,
						honor_workarea = true,
						margins = {
							top = dpi(5),
							right = dpi(5),
						},
					}
				)
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

awesome.connect_signal(
	"module::sound_picker:show",
	function(_bool)
		local focused = awful.screen.focused()
		local sound_picker = focused.sound_picker

		awful.placement.top_right(
			sound_picker,
			{
				honor_workarea = true,
				margins = {
					top = dpi(33),
					right = dpi(5),
				},
			}
		)
	end
)

awesome.connect_signal("sound-picker::opened", function()
	awesome.emit_signal("module::sound_picker:show")
end)

awesome.connect_signal("sound-picker::closed", function()
end)


return build

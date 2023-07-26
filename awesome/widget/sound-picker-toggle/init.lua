local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local watch = awful.widget.watch
local dpi = require("beautiful").xresources.apply_dpi
local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. "widget/sound-picker-toggle/icons/"
local clickable_container = require("widget.clickable-container")

local return_button = function()
	local widget = wibox.widget({
		{
			id = "icon",
			image = widget_icon_dir .. "volume.svg",
			widget = wibox.widget.imagebox,
			resize = true,
		},
		layout = wibox.layout.align.horizontal,
	})

	local widget_button = wibox.widget({
		{
			widget,
			margins = dpi(7),
			widget = wibox.container.margin,
		},
		widget = clickable_container,
	})

	local sound_picker_tooltip = awful.tooltip {
		objects = {widget_button},
		mode = 'outside',
		align = 'bottom',
		margin_leftright = dpi(8),
		margin_topbottom = dpi(8),
		preferred_positions = {'bottom', 'right', 'left', 'top'},
		markup = "Manage sound input",
	}

	widget_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
		local sound_picker = awful.screen.focused().sound_picker
		if sound_picker.visible then
			sound_picker.visible = false
			awesome.emit_signal("sound-picker::closed")
		else
			sound_picker.visible = true
			awesome.emit_signal("sound-picker::opened")
		end
	end)))

	return widget_button
end

return return_button

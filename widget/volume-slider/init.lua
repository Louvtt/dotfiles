local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local spawn = awful.spawn
local dpi = beautiful.xresources.apply_dpi
local icons = require("theme.icons")
local icon_class = require("widget.meters.entities.icon")
local name_class = require("widget.meters.entities.name")

local height_map = {
	floppy = dpi(2),
}
local handle_width_map = {
	floppy = dpi(15),
}

local action_name = name_class:new("Volume", _, _)
local icon = icon_class:new(icons.volume, _, true, _)

local slider = wibox.widget({
	nil,
	{
		id = "volume_slider",
		bar_shape = gears.shape.rounded_rect,
		bar_height = height_map[THEME] or dpi(24),
		bar_color = "#ffffff20",
		bar_active_color = "#f2f2f2EE",
		handle_color = "#ffffff",
		handle_shape = gears.shape.circle,
		handle_width = handle_width_map[THEME] or dpi(24),
		handle_border_color = "#00000012",
		handle_border_width = dpi(1),
		maximum = 100,
		widget = wibox.widget.slider,
	},
	nil,
	expand = "none",
	forced_height = dpi(24),
	layout = wibox.layout.align.vertical,
})

local volume_slider = slider.volume_slider

volume_slider:connect_signal("property::value", function()
	local volume_level = volume_slider:get_value()

	spawn("pactl set-sink-volume @DEFAULT_SINK@ " .. volume_level .. "%", false)

	-- Update volume osd
	awesome.emit_signal("module::volume_osd", volume_level)
end)

volume_slider:buttons(gears.table.join(
	awful.button({}, 4, nil, function()
		volume_slider:set_value(volume_slider:get_value() + 5)
		if volume_slider:get_value() > 100 then
			volume_slider:set_value(100)
			return
		end
	end),
	awful.button({}, 5, nil, function()
		volume_slider:set_value(volume_slider:get_value() - 5)
		if volume_slider:get_value() < 0 then
			volume_slider:set_value(0)
			return
		end
	end)
))

local update_slider = function()
	awful.spawn.easy_async_with_shell([[bash -c "pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | grep -o '[0-9]*%'"]], function(stdout)
		local volume = string.match(stdout, "(%d+)%%")
		volume_slider:set_value(tonumber(volume))
	end)
end

-- Update on startup
update_slider()

local action_jump = function()
	local sli_value = volume_slider:get_value()
	local new_value = 0

	if sli_value >= 0 and sli_value < 50 then
		new_value = 50
	elseif sli_value >= 50 and sli_value < 100 then
		new_value = 100
	else
		new_value = 0
	end
	volume_slider:set_value(new_value)
end

icon:buttons(awful.util.table.join(awful.button({}, 1, nil, function()
	action_jump()
end)))

-- The emit will come from the global keybind
awesome.connect_signal("widget::volume", function()
	update_slider()
end)

-- The emit will come from the OSD
awesome.connect_signal("widget::volume:update", function(value)
	volume_slider:set_value(tonumber(value))
end)

local volume_setting = wibox.widget({
	layout = wibox.layout.fixed.vertical,
	forced_height = dpi(48),
	spacing = dpi(5),
	action_name,
	{
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5),
		{
			layout = wibox.layout.align.vertical,
			expand = "none",
			nil,
			{
				layout = wibox.layout.fixed.horizontal,
				forced_height = dpi(24),
				forced_width = dpi(24),
				icon,
			},
			nil,
		},
		slider,
	},
})

awesome.connect_signal("widget::volume:augment", function(value)
	spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +" .. value .. "%", false)
end)

awesome.connect_signal("widget::volume:decrease", function(value)
	spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -" .. value .. "%", false)
end)

-- Set volume to 0 (could mute but need to add prop for that)
awesome.connect_signal("widget::volume:mute", function (value)
	spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ 0%")
end)

return volume_setting

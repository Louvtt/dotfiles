local name_class = require("widget.shared.components.name")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local awful = require("awful")
local gears = require("gears")

local element = {
	margin = dpi(5),
	bg = beautiful.groups_bg,
	selected_bg = "#EEEEEE",
	fg = beautiful.fg_modal,
	current_bg  = "#FFFFFF",
	selected_fg = "#000000",
	border_width = dpi(1),
	border_color = beautiful.border_modal,
	spacing = dpi(5),
}

---@param name_id string
---@param name string
function element:new(name_id, name, current)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.name_id = name_id
	o.name = name
	o.current = current
	o.name_widget = name_class:new(o.name, _, _)
	local layout_widget = wibox.widget {
		o.name_widget,
		nil,
		nil,
		layout = wibox.layout.flex.horizontal,
		spacing = o.spacing,
		bg = beautiful.groups_bg,
	}
	local margin_widget = wibox.container.margin(layout_widget)
	margin_widget.margins = o.margin
	o.widget = wibox.container.background(margin_widget, o.bg, _)

	o:register_events()
	o.widget:buttons(gears.table.join(awful.button({}, 1, nil, function()
		o:confirm()
	end)))

	return o
end

function element:confirm()
	awful.spawn.with_shell("pactl set-default-sink " .. self.name_id)
	local sound_picker = awful.screen.focused().sound_picker
	sound_picker.visible = false
end

function element:select()
	self.widget.bg = self.selected_bg
	self.widget.fg = self.selected_fg
end

function element:deselect()
	self.widget.bg = self.bg
	self.widget.fg = self.fg
end

function element:register_events()
	self.widget:connect_signal("mouse::enter", function()
		self:select()
	end)
	self.widget:connect_signal("mouse::leave", function()
		self:deselect()
	end)
end

return element

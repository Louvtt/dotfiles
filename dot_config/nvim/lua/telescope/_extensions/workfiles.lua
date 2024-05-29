-- From https://github.com/glepnir

local telescope = require('telescope')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values

local work_paths = '/Documents/L3,/Documents/Stage\\ L3'

local workfiles_list = function()
  local dirs = vim.split(work_paths, ',')
  local list = {}
  for _, dir in pairs(dirs) do
    local p = io.popen('find ' .. vim.env.HOME .. dir .. ' -maxdepth 2 -type d')
    for file in p:lines() do
      table.insert(list, file)
    end
  end
  return list
end

local workfiles = function(opts)
  opts = opts or {}
  local results = workfiles_list()

  pickers
    .new(opts, {
      prompt_title = 'find in workfiles',
      results_title = 'Work Files',
      finder = finders.new_table({
        results = results,
        entry_maker = make_entry.gen_from_file(opts),
      }),
      previewer = conf.file_previewer(opts),
      sorter = conf.file_sorter(opts),
    })
    :find()
end

return telescope.register_extension({ exports = { workfiles = workfiles } })

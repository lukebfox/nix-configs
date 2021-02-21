local lfs = require ('lfs')

local icons = {}
local icons_dir = os.getenv('HOME') .. '/.config/awesome/icons/'

local get_icons_from = function(directory)
  for file in lfs.dir(directory) do
    local filetype = lfs.attributes(directory .. file, "mode")
    if (filetype == "file" or filetype == "link")
      and file ~= "init.lua" then
      -- strip .svg extension for the variable identifier
      icons[string.sub(file,1,-5)] = directory .. file
    end
  end
end
get_icons_from(icons_dir)
get_icons_from(icons_dir .. 'tag-list/')

local msg = "Icons: "
for k,v in pairs(icons) do
  msg = msg .. k .. ", "
end
--assert(next(icons) == nil, msg)
--assert(icons.power)
return icons

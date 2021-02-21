local awful   = require('awful')
local naughty = require('naughty')

local apps = require('configuration.apps')
local icons = require('icons')

local run_once = function(cmd)
  local findme = cmd
  local firstspace = cmd:find(' ')
  if firstspace then
    findme = cmd:sub(0, firstspace - 1)
  end
  awful.spawn.easy_async_with_shell(
    string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd),
    function(stdout, stderr)
      -- Debugger
      if not stderr or stderr == '' then return end

      naughty.notification({
          app_name = 'Start-up Applications',
          title = '<b>Oof! Error detected when starting an application!</b>',
          message = stderr:gsub('%\n', ''),
          timeout = 20,
          icon = icons.awesome
      })
    end
  )
end

for _, app in ipairs(apps.run_on_start_up) do
  run_once(app)
end

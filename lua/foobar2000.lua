local foobar2000 = {}

local time_units = {
  ['1s'] = '1 second',
  ['5s'] = '5 seconds',
  ['10s'] = '10 seconds',
  ['30s'] = '30 seconds',
  ['1m'] = '1 minute',
  ['2m'] = '2 minutes',
  ['5m'] = '5 minutes',
  ['10m'] = '10 minutes'
}

local function config(userConfig)
  if userConfig.seek_duration then
    if not time_units[userConfig.seek_duration] then
      vim.api.nvim_err_writeln('[foobar2000.nvim] Invalid `config.seek_duration` value. Please use one of the following time units: 1s, 5s, 10s, 30s, 1m, 5m, 10m')
      return
    end
  end

  return {
    path = userConfig.path or 'foobar2000.exe',
    seek_duration = userConfig.seek_duration or '30s'
  }
end

function foobar2000.setup(userConfig)
  local config = config(userConfig or {})

  if not config then
    return
  end

  local path = config.path

  if userConfig.path then
    local stat = vim.loop.fs_stat(path)
    if not stat or not stat.type == 'file' then
      vim.notify('[foobar2000.nvim] Given path is invalid. Defaulting to "foobar2000.exe"', vim.log.levels.WARN)
      path = 'foobar2000.exe'
    end
  else
    path = 'foobar2000.exe'
  end

  vim.api.nvim_create_user_command('FoobarAdd', function(args)
    if args.bang then
      os.execute(path .. ' /immediate /add "' .. table.concat(args.fargs, ' ') .. '"')
    else
      os.execute(path .. ' /add "' .. table.concat(args.fargs, ' ') .. '"')
    end
  end, { bang = true, nargs = '+' })

  vim.api.nvim_create_user_command('FoobarPlay', function()
    os.execute(path .. ' /play')
  end, {})

  vim.api.nvim_create_user_command('FoobarPause', function()
    os.execute(path .. ' /pause')
  end, {})

  vim.api.nvim_create_user_command('FoobarPrev', function()
    os.execute(path .. ' /prev')
  end, {})

  vim.api.nvim_create_user_command('FoobarNext', function()
    os.execute(path .. ' /next')
  end, {})

  vim.api.nvim_create_user_command('FoobarStop', function()
    os.execute(path .. ' /stop')
  end, {})

  vim.api.nvim_create_user_command('FoobarRand', function()
    os.execute(path .. ' /rand')
  end, {})

  vim.api.nvim_create_user_command('FoobarShuffle', function(args)
    local value = args.fargs[1]

    if value ~= 'tracks' and
      value ~= 'albums' and
      value ~= 'playlists' and
      value ~= 'off' then
        vim.api.nvim_err_writeln('Invalid value. Use one of: tracks, albums, playlists, off')
    end

    if value == 'off' then
      os.execute(path .. ' /command:Default')
    else
      os.execute(path .. ' "/command:Shuffle (' .. value .. ')"')
    end

    vim.api.nvim_err_writeln('Invalid option. Use one of: tracks, albums, playlists, off')
  end, { nargs = 1 })

  vim.api.nvim_create_user_command('FoobarRepeatTrack', function()
    os.execute(path .. ' "/command:Repeat (track)"')
  end, {})

  vim.api.nvim_create_user_command('FoobarRepeatPlaylist', function()
    os.execute(path .. ' "/command:Repeat (playlist)"')
  end, {})

  vim.api.nvim_create_user_command('FoobarRepeatOff', function()
    os.execute(path .. ' /command:Default')
  end, {})

  vim.api.nvim_create_user_command('FoobarSeekAhead', function(args)
    local value

    if #args.fargs == 0 then
      value = config.seek_duration
    else
      value = time_units[args.fargs[1]]
    end

    if value then
      os.execute(path .. ' "/command:Ahead by ' .. value .. '"')
    else
      vim.api.nvim_err_writeln('Invalid value. Use one of: 1s, 5s, 10s, 30s, 1m, 2m, 5m, 10m')
    end
  end, { nargs = "?" })

  vim.api.nvim_create_user_command('FoobarSeekBack', function(args)
    local value

    if #args.fargs == 0 then
      value = config.seek_duration
    else
      value = time_units[args.fargs[1]]
    end

    if value then
      os.execute(path .. ' "/command:Back by ' .. value .. '"')
    else
      vim.api.nvim_err_writeln('Invalid value. Use one of: 1s, 5s, 10s, 30s, 1m, 2m, 5m, 10m')
    end
  end, { nargs = "?" })

  vim.api.nvim_create_user_command('FoobarVolumeUp', function()
    os.execute(path .. ' \'/command:Volume up\'')
  end, {})

  vim.api.nvim_create_user_command('FoobarVolumeDown', function()
    os.execute(path .. ' "/command:Volume down"')
  end, {})

  vim.api.nvim_create_user_command('FoobarVolume', function(args)
    local value = args.fargs[1]

    if value ~= '0' and
      value ~= '-0' and
      value ~= '-3' and
      value ~= '-6' and
      value ~= '-9' and
      value ~= '-12' and
      value ~= '-15' and
      value ~= '-18' and
      value ~= '-21' then
        vim.api.nvim_err_writeln('Invalid value. Use one of: 0, -3, -6, -9, -12, -15, -18, -21')
    end

    if value == '0' then
      value = '-0'
    end

    os.execute(path .. ' "/command:Set to ' .. args.fargs[1] .. ' dB"')
  end, { nargs = 1 })

  vim.api.nvim_create_user_command('FoobarMute', function()
    os.execute(path .. ' /command:VolumeMute')
  end, {})

  vim.api.nvim_create_user_command('FoobarShow', function()
    os.execute(path .. ' /show')
  end, {})

  vim.api.nvim_create_user_command('FoobarHide', function()
    os.execute(path .. ' /hide')
  end, {})

  vim.api.nvim_create_user_command('FoobarExit', function()
    os.execute(path .. ' /exit')
  end, {})

  vim.api.nvim_create_user_command('FoobarCommand', function(args)
    os.execute(path .. ' "/command:' .. table.concat(args.fargs, ' ') .. '"')
  end, { nargs = '+' })
end

return foobar2000

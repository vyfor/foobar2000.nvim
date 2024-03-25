# 🧩 foobar2000.nvim

🎶 A lightweight Neovim plugin for interacting with the foobar2000 audio player.

## 📦 Installation
```lua
{
  'reblast/foobar2000.nvim',
}
```

## 🔧 Configuration
```lua
require('foobar2000').setup({
  path = 'foobar2000.exe', -- Path to the foobar2000 executable (optional)
  seek_duration = '30s', -- Seek duration, can be one of: 1s, 5s, 10s, 30s, 1m, 5m, 10m
})
```

### ⌨️ User commands
- `FoobarAdd <files>` - Appends the specified files to the current playlist instead. Using `FoobarAdd!` bypasses the "please wait" dialog.
- `FoobarPlay` - Starts playback.
- `FoobarPause` - Pauses the player.
- `FoobarPrev` - Plays the previous track in the current playlist.
- `FoobarNext` - Plays the next track in the current playlist.
- `FoobarStop` - Stops playback.
- `FoobarRand` - Plays a random track in the current playlist.
- `FoobarShuffle <option>` - Sets the shuffle mode of the current playlist. Available options are: `tracks`, `albums`, `playlists` or `off`.
- `FoobarRepeatTrack` - Repeats the current track.
- `FoobarRepeatPlaylist` - Repeats the current playlist.
- `FoobarRepeatOff` - Disables the repeat mode.
- `FoobarSeekAhead` - Seeks ahead by 30 seconds.
- `FoobarSeekBack` - Seeks back by 30 seconds.
- `FoobarVolumeUp` - Increases the volume.
- `FoobarVolumeDown` - Decreases the volume.
- `FoobarMute` - Mutes the volume.
- `FoobarShow` - Shows the main foobar2000 window.
- `FoobarHide` - Hides the main foobar2000 window.
- `FoobarExit` - Exits foobar2000.
- `FoobarCommand <command>` - Sends the specified command to foobar2000. The list of available commands can be found under "Preferences > Keyboard Shortcuts".

## 🌱 Contributing
This project is in beta. Feel free to open an issue or pull request for missing features. You can also contact me on Discord **[poxuizm](https://discord.com/users/446729269872427018)** if you have any questions.

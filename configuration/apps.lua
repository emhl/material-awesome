local filesystem = require('gears.filesystem')

-- Thanks to jo148 on github for making rofi dpi aware!
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi
local rofi_command = 'env /usr/bin/rofi -dpi ' .. get_dpi() .. ' -width ' .. with_dpi(400) .. ' -show drun -theme ' .. filesystem.get_configuration_dir() .. '/configuration/rofi.rasi -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"'

return {
  -- List of apps to start by default on some actions
  default = {
    terminal = 'xfce4-terminal',
    rofi = rofi_command,
    lock = 'xflock4',
    screenshot = 'flameshot gui -c -s', 
    region_screenshot = 'flameshot gui', 
    delayed_screenshot = 'flameshot screen -d 5000 -c', 
    ss_and_edit_screenshot = 'flameshot gui',
    
    -- Editing these also edits the default program
    -- associated with each tag/workspace
    browser = 'env brave',
    write = 'xournalpp',
    editor = 'subl',
    social = 'env discord-canary',
    game = rofi_command,
    files = 'thunar',
    music = rofi_command
  },
  -- List of apps to start once on start-up
  run_on_start_up = {
    'xset b off', -- stop beeping
    -- 'picom --config ' .. filesystem.get_configuration_dir() .. '/configuration/picom.conf',
    'nm-applet --indicator', -- wifi
    'xfce4-power-manager', -- Power manager
    'ibus-daemon --xim --daemonize', -- Ibus daemon for keyboard
    '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
    -- '/usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
    -- 'blueman-applet', -- bluetooth tray
    --'geary --hidden', -- Email client
    'xfce4-clipman', -- clipboard manager
    'pamac-tray', -- package manager tray icon
    'kdeconnect-indicator', -- KDE Connect
    'light-locker', -- lockscreen deamon 
    'pasystray --notify=all -g --volume-max=200 --volume-inc=5', -- audio manager sytray
    'flameshot', -- screenshots
    'nmcli r wifi on', -- enable wifi
    -- 'deadd-notification-center', -- notification deamon & center 
    -- Add applications that need to be killed between reloads
    -- to avoid multipled instances, inside the awspawn script
    -- '~/.config/awesome/configuration/awspawn' -- Spawn "dirty" apps that can linger between sessions
  }
}

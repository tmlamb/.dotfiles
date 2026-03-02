#!/bin/bash
# Send the header so that swaybar knows we want to use JSON:
echo '{ "version": 1 }'

# Begin the endless array.
echo '['

# We send an empty first array of blocks to make the loop simpler:
echo '[]'

# Now send blocks with information forever:
while :;
do
  echo -n ",["

  # blut=$(bluetoothctl devices Connected | grep -E -o '\S+$')
  # if [ -n "$blut" ]; then
  blutregex="^Device.* (\S+$)"
  blut=$(bluetoothctl devices Connected | grep "^Device " | head -n 1)
  if [[ -n "$blut" && $blut =~ $blutregex ]]; then
    device=${BASH_REMATCH[1]}
    echo -n "{\"name\":\"id_bluetooth\",\"full_text\":\"BT:${device}\"},"
  fi

  drop=$(dropbox-cli status)

  if [[ $drop != "Up to date" ]]; then
    if [[ $drop = "Dropbox isn't running!" ]]; then
      echo -n "{\"name\":\"id_dropbox\",\"full_text\":\"DropBox:Off\",\"color\":\"#FF0000\"},"
    else
      echo -n "{\"name\":\"id_dropbox\",\"full_text\":\"DropBox:Unknown\",\"color\":\"#FFA500\"},"
    fi
  fi

  charging=$(cat /sys/class/power_supply/BAT1/status)
  batt=$(cat /sys/class/power_supply/BAT1/capacity)
  if [ "$batt" -lt 101 ]; then
    if [ "$charging" = "Charging" ]; then
      echo -n "{\"name\":\"id_battery\",\"full_text\":\"Bat:${batt}%\", \"color\":\"#96d294\"},"
    elif [ "$batt" -lt 50 ]; then
      echo -n "{\"name\":\"id_battery\",\"full_text\":\"Bat:${batt}%\", \"color\":\"#FF0000\"},"
    else
      echo -n "{\"name\":\"id_battery\",\"full_text\":\"Bat:${batt}%\"},"
    fi
  fi

  if pactl get-source-mute \@DEFAULT_SOURCE@ | grep -q 'no' ; then
    echo -n "{\"name\":\"id_microphone\",\"full_text\":\"Mic:On\",\"color\":\"#FF0000\"},"
  fi

  ssidregex="wifi\s+connected\s+(\S+)"
  status=$(nmcli device status)
  if [[ $status =~ $ssidregex ]]; then
    ssid=${BASH_REMATCH[1]}
    echo -n "{\"name\":\"id_ssid\",\"full_text\":\"WiFi:${ssid}\"},"
  else
    echo -n "{\"name\":\"id_ssid\",\"full_text\":\"No WiFi\",\"color\":\"#FF0000\"},"
  fi

  sinkmute=$(pactl get-sink-mute \@DEFAULT_SINK@)
  if pactl get-sink-mute \@DEFAULT_SINK@ | grep -q 'yes' ; then
    echo -n "{\"name\":\"id_volume\",\"full_text\":\"Vol:Mute\"},"
  else
    echo -n "{\"name\":\"id_volume\",\"color\":\"#FFA500\",\"full_text\":\"Vol:$(pactl get-sink-volume \@DEFAULT_SINK@ | grep -E -o 'right: .+ ([0-9]+)%' | grep -E -o '[0-9]+%' | head -1)\"},"
  fi

  load=$(cut -d' ' -f1 /proc/loadavg)
  if awk "BEGIN {exit !($load > 3)}"; then
    echo -n "{\"name\":\"id_load\",\"full_text\":\"Load:${load}\", \"color\":\"#FF0000\"},"
  elif awk "BEGIN {exit !($load > 1.5)}"; then
    echo -n "{\"name\":\"id_load\",\"full_text\":\"Load:${load}\", \"color\":\"#FFA500\"},"
  else
    echo -n "{\"name\":\"id_load\",\"full_text\":\"Load:${load}\"},"
  fi

  echo -n "{\"name\":\"id_time\",\"full_text\":\"$(date +"%b %-d %H:%M:%S")\"}"

  echo -n "]"
  sleep 1
done

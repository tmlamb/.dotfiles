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

  batt=$(cat /sys/class/power_supply/BAT1/capacity)
  if [ "$batt" -lt 60 ]; then
    echo -n "{\"name\":\"id_battery\",\"full_text\":\"Bat:${batt}%\"},"
  fi

  if pactl get-source-mute \@DEFAULT_SOURCE@ | grep -q 'no' ; then
    echo -n "{\"name\":\"id_microphone\",\"full_text\":\"Mic:On\"},"
  fi

  ssidregex="wifi\s+connected\s+(\S+)"
  status=$(nmcli device status)
  if [[ $status =~ $ssidregex ]]; then
    ssid=${BASH_REMATCH[1]}
    echo -n "{\"name\":\"id_ssid\",\"full_text\":\"WiFi:${ssid}\"},"
  fi

  sinkmute=$(pactl get-sink-mute \@DEFAULT_SINK@)
  if pactl get-sink-mute \@DEFAULT_SINK@ | grep -q 'yes' ; then
    echo -n "{\"name\":\"id_ssid\",\"full_text\":\"Vol:Mute\"},"
  else
    echo -n "{\"name\":\"id_volume\",\"full_text\":\"Vol:$(pactl get-sink-volume \@DEFAULT_SINK@ | grep -E -o 'right: .+ ([0-9]+)%' | grep -E -o '[0-9]+%' | head -1)\"},"
  fi

  echo -n "{\"name\":\"id_time\",\"full_text\":\"$(date +"%F %H:%M:%S")\"}"

  echo -n "]"
  sleep 1
done
    # echo -n "{\"name\":\"id_battery\",\"background\":\"#283593\",\"full_text\":\"bat:${batt}%\"},"

# Status Bar:
# set $wifi $(nmcli radio wifi | sed -e "s/enabled/on/" -e "s/disabled/off/")
# set $volu $(pactl get-sink-volume \@DEFAULT_SINK@ | grep -E -o 'right: .+ ([0-9]+)%' | grep -E -o '[0-9]+%' | head -1)
# set $micr $(pactl get-source-mute \@DEFAULT_SOURCE@ | grep -q 'no' && echo 'on' || echo 'off')
# set $batt $(cat /sys/class/power_supply/BAT1/capacity)
# set $date $(date +"%F %H:%M:%S")
# set $blth $(bluetoothctl devices Connected | grep -E -o '\S+$')
# load
# ssd space
# set $status bt:$blth\|wifi:$wifi\|vol:"$volu"\|mic:$micr\|bat:$batt%\|$date

# set $status $date

# if [ "$batt" -lt 60 ]; then
#   status="$status|bat:$batt%"
# fi

# if [ -n "$blth" ]; then
#   status="bt:$blth|$status"
# fi
# status="vol:\"$volu\"|mic:$micr|$status"

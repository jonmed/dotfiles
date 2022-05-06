#!/usr/bin/env bash
PATH=/home/usuario/.local/bin:/usr/bin

TIME=$(pomodoro status --format "%r")
if [ "$TIME" = "0:00" ]; then
  pomodoro clear
  COUNT=300
  START=$COUNT
  until [ "$COUNT" -eq "0" ]; do
    ((COUNT-=1))
    PERCENT=$((100-100*COUNT/START))
    echo "#<span font=\"20\">Time remaining$(echo "obase=60;$COUNT" | bc)</span>"
    echo $PERCENT
    sleep 1
  done | zenity --title "<span font="20">Break Timer</span>" --progress --percentage=0\
    --no-cancel --text "" --auto-close
  if zenity --title "<span font="20">Pomodoro</span>" --question  --text "<span font="20">Start new pomodoro?</span>"
  then
    pomodoro start
    TIME=$(pomodoro status --format "%r")
    notify-send -t 5000 -i info "Time remaining: $TIME"
  fi
fi
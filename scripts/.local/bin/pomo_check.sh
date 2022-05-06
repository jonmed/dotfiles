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
    echo "#Time remaining$(echo "obase=60;$COUNT" | bc)"
    echo $PERCENT
    sleep 1
  done | zenity --title "Break Timer" --progress --percentage=0\
    --no-cancel --text "" --auto-close
  if zenity --title "Pomodoro" --question  --text "Start new pomodoro?"
  then
    pomodoro start
    TIME=$(pomodoro status --format "%r")
    notify-send -t 5000 -i info "Time remaining: $TIME"
  fi
fi

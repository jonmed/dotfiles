#!/usr/bin/env bash
PATH=/home/usuario/.local/bin:/usr/bin

timestamp() {
  date +"%s"
}

show_break_window() {
  COUNT="$1"
  START="$2"
  until [ "$COUNT" -eq "0" ]; do
    ((COUNT-=1))
    PERCENT=$((100-100*COUNT/START))
    echo "#Time remaining$(echo "obase=60;$COUNT" | bc)"
    echo $PERCENT
    sleep 1
  done | zenity --title "Break Timer" --progress --percentage=0\
    --no-cancel --text "" --auto-close
}

TIME=$(pomodoro status --format "%r")
if [ "$TIME" = "0:00" ]; then
  pomodoro clear
  time_to_rest=300
  start_time=$(timestamp)
  tdiff=0
  until [ "$tdiff" -ge "$time_to_rest" ]; do
    break_time=$((time_to_rest-tdiff))
    show_break_window "$break_time" "$time_to_rest"
    end_time=$(timestamp)
    tdiff=$((end_time-start_time))
  done
  if zenity --title "Pomodoro" --question  --text "Start new pomodoro?"
  then
    pomodoro start
    TIME=$(pomodoro status --format "%r")
    notify-send -t 5000 -i info "Time remaining: $TIME"
  fi
fi

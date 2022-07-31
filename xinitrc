#!/usr/bin/env bash


# invoke global X session script
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

feh --bg-fill $HOME/annex/pictures/wallpapers/rickandmorty1.png

# set via system config
#setxkbmap -option ctrl:nocaps # map caps to ctrl
#setxkbmap -layout de


Day() {
  printf `date "+%e" | sed -e 's/\ //'`

  case `date +%d` in
    1|21|31) printf "${day}st";;
    2|22)    printf "${day}nd";;
    3|23)    printf "${day}rd";;
    *)       printf "${day}th";;
  esac
}

Battery() {
  dir=/sys/class/power_supply/BAT0

  grep -q ^C "${dir}"/status && printf +
  cat "${dir}"/capacity
}

 bHasBattery=false
 if [ -d /sys/class/power_supply/BAT0 ]; then
   bHasBattery=true
 fi
 
 bHasBacklight=false
 if [[ $(command -v light) ]]; then
   bHasBacklight=true
 fi

while true; do
  text=""

  # date and time
  text+="$(date +%Y-%m-%d)"
  text+=" | $(date +%H:%M)"

  # cpu usage
  text+=" | CPU $(top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1"%"}')"

  # memory
  text+=" | RAM $(free -m | awk '/Mem/ {printf "%d", $3 * 100 / $2}')%"

  # volume
  text+=" | VOL $(amixer get Master | awk '$0~/%/{print $5}' | head -n 1 | tr -d '[]')"

  # backlight
  if $bHasBacklight; then
    text+=" | LIT $(light | cut -d. -f1)%"
  fi

  # battery
  if $bHasBattery; then
    text+=" | BAT $(Battery)%"
  fi

  #TODO bluetooth if powered and or connected (then device)
  #TODO ncmpcpp line if playing
  #TODO if battery is low, show warning in red
  #TODO scheduled shutdown timer
  #TODO use icons (then maybe a icon for weather too)
  #TODO make readable
  #TODO wifi signal strength / connection status
  #TODO git annex currently syncing
  #TODO remaining battery time till auto shutdown (need that too)
  #TODO https://dwm.suckless.org/patches/statuscolors/
  #TPDP Powerline background / charackters (idk how)
  #TODO dynamic (only if higher than threshold) network i/o speeds
  #TODO "dynamic" disk i/o
  #TODO regularly updated internet speedtest
  #TODO server04 status
  #TODO rice it somehow (different font everywhere?) to make it readable on laptop screen (maybe even more hidden when not relevant)

  # xsetroot -name "`date \"+%a, %b \`Day\` %k:%M\"` | `Battery`%"
  xsetroot -name "$text"
  sleep 15
done &

printf "starting dwm once"
exec dwm

# handle dmenu restart option
#While [ -f /tmp/dwmrestart.lock ]; do
#  printf "dwm restarting"
#  sleep 1
#  rm /tmp/dwmrestart.lock
#  exec dwm
#Done

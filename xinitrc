#!/usr/bin/env bash


# invoke global X session script
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi




# Set the default session
session=${1:-dwm}

case $session in
    steam)
        # Set the autorandr profile to "tv"
        autorandr tv

        # Start a fitting window manager for Steam Big Picture mode
        # For example, you can use Openbox (install it if you haven't already)
        # You can replace "exec openbox-session" with your preferred WM for this mode
        exec openbox-session &

        # Launch Steam in Big Picture mode
        exec steam -bigpicture
        ;;  # desktop mode

    dwm)
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
      if [[ $(command -v brightnessctl g) ]]; then
        bHasBacklight=true
      fi

      bHasBluetooth=false
        if [[ $(command -v bluetoothctl g) ]]; then
          bHasBluetooth=true
        fi

      while true; do
        text=""

        # org clock status FIXME doesnt work sometimes
        orgClockString="$(emacsclient -e "(if org-clock-current-task (string-trim (substring-no-properties (org-clock-get-clock-string))))")"
        if [[ $orgClockString != "" && $orgClockString != "nil" ]]; then
          text+="${orgClockString:1:-1} | "
        else
          text+="clocked out | "
        fi


        # low battery
        if $bHasBattery; then
          if [ $(Battery) -le 20 ]; then
            text="BATTERY LOW | "
          fi
        fi

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
          text+=" | LIT $(($(brightnessctl g) * 100 / 255))%"
        fi

        # bluetooth
        # if $bHasBluetooth; then
        #   isPowered=$(bluetoothctl show | grep Powered | awk '{print $2}')
        #   isConnect=$(bluetoothctl show | grep Connected | awk '{print $2}')
        #   if [ "$isPowered" = "yes" ]; then
        #     if [ "$isConnect" = "yes" ]; then
        #       text+=" | $(bluetoothctl show | grep Name | awk '{print $2}')"
        #     else
        #       text+=" | "
        #     fi
        #   else
        #     text+=" | "
        #   fi
        # fi

        # battery
        if $bHasBattery; then
          text+=" | BAT $(Battery)%"
        fi

        #TODO ncmpcpp line if playing (scrolling)
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

      autorandr vdesk ;
      feh --bg-fill $HOME/annex/pictures/wallpapers/rickandmorty1.png ;
      dunst &
      exec dwm

      # handle dmenu restart option
      #While [ -f /tmp/dwmrestart.lock ]; do
      #  printf "dwm restarting"
      #  sleep 1
      #  rm /tmp/dwmrestart.lock
      #  exec dwm
      #Done
      ;;
    *)
        echo "No session defined"
        exit 1
        ;;
esac

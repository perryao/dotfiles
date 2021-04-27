case `uname` in
  Darwin)
    # commands for OS X go here
  ;;
  Linux)
    # commands for Linux go here
    if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] &&  [ "$XDG_VTNR" -eq 1 ]; then
        exec startx
    fi
  ;;
esac
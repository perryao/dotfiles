eval $(ssh-agent)
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
xrdb -merge ~/.Xresources
#exec dwm
# exec cinnamon-session
# exec i3 -V >> ~/i3log-$(date + '%F-%k-%M-%S') 2>&1
exec i3

# export XDG_CURRENT_DESKTOP=Budgie:GNOME
# exec budgie-desktop
# export XDG_CURRENT_DESKTOP=GNOME-Classic:GNOME
# export GNOME_SHELL_SESSION_MODE=classic
# exec gnome-session --session=gnome-classic

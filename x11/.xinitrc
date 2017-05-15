eval $(ssh-agent)
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
xrdb -merge ~/.Xresources
#exec dwm
#exec cinnamon-session
#exec i3 -V >> ~/i3log-$(date + '%F-%k-%M-%S') 2>&1
exec i3

#/bin/sh

export IP=$(ifconfig -l | xargs -n1 ipconfig getifaddr)
/usr/X11/bin/xhost + $IP > /dev/null
/usr/X11/bin/xhost + local:docker > /dev/null

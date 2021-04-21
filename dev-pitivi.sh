#!/bin/sh

export IP=$(ifconfig -l | xargs -n1 ipconfig getifaddr)
/usr/X11/bin/xhost + $IP > /dev/null
/usr/X11/bin/xhost + local:docker > /dev/null

if [ ! "$(docker ps -q -f name=pitivi-dev)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=pitivi-dev)" ]; then
        docker rm pitivi-dev > /dev/null
    fi

    docker pull soft261/pitivi-dev:latest
    docker run -it --privileged --name pitivi-dev -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/pitivi/pitivi-dev:/pitivi-dev soft261/pitivi-dev:latest
else
    echo "pitivi-dev container already running as: "
    docker ps -q -f name=pitivi-dev
fi

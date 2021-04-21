All of your Pitivi files will live outside the Docker container and be mounted inside it when it runs.  So make sure you create a `pitivi-dev` folder somewhere and inside that folder, use Git to clone your fork of the repository.

Each time your X server runs, you will want to grant access to your docker containers:

```sh
export IP=$(ifconfig -l | xargs -n1 ipconfig getifaddr)
/usr/X11/bin/xhost + $IP
/usr/X11/bin/xhost + local:docker
```

Then you can run the image in a container (be sure to set the path to your `pitivi-dev` folder):

```sh
docker rm pitivi-dev
docker run -it --privileged --name pitivi-dev -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v /path/to/your/pitivi-dev:/pitivi-dev soft261/pitivi-dev:latest
```

Now you can run `source bin/pitivi-env` as normal and then run the `ptvtests` or `pitivi` commands.

If you need to run `gdb` within this environment, you can with the following command:

```sh
ptvenv gdb python3 -ex "\"run /pitivi-dev/pitivi/bin/pitivi\""
```

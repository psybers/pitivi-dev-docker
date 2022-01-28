FROM ubuntu:focal
#
RUN set -e \
#
# Update Ubuntu repos and install dependencies
#
&& apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --yes \
    bison \
    build-essential \
    bzip2 \
    dbus-x11 \
    flatpak \
    flatpak-builder \
    flex \
    frei0r-plugins \
    gdb \
    gettext \
    gir1.2-gsound \
    gir1.2-gst-plugins-bad-1.0 \
    gir1.2-gst-plugins-base-1.0 \
    gir1.2-notify \
    gir1.2-peas-1.0 \
    git \
    glade \
    gobject-introspection \
    gperf \
    gstreamer1.0-libav \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-pulseaudio \
    gstreamer1.0-tools \
    libcairo2-dev \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libgirepository1.0-dev \
    libgstreamer-plugins-bad1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer-plugins-good1.0-dev \
    libgtk-3-dev \
    libharfbuzz-dev \
    libjpeg-turbo8-dev \
    libmount-dev \
    libpeas-1.0-0 \
    libpulse0 \
    libvorbis-dev \
    nasm \
    netsurf-common \
    ninja-build \
    openssh-client \
    openssl \
    patch \
    pkg-config \
    python3 \
    python3-cairo-dev \
    python3-gi-cairo \
    python3-pip \
    vim \
    yaru-theme-icon \
&& pip3 install --upgrade pip \
&& pip3 install --upgrade matplotlib meson numpy pre-commit pylint \
#
# Clean-up
#
&& rm --recursive --force \
    /usr/share/doc/* \
    /usr/share/man/* \
    /var/cache/apt/*.bin \
    /var/cache/apt/archives/*.deb \
    /var/cache/apt/archives/partial/*.deb \
    /var/cache/debconf/*.old \
    /var/lib/apt/lists/* \
    /var/lib/dpkg/info/* \
    /var/log/*.log \
    /var/log/apt \
#
# pitivi dev settings
#
&& mkdir pitivi-dev \
&& echo "function ptvenv { if [[ \"\$*\" == \"--update\" ]] ; then /pitivi-dev/pitivi/build/flatpak/pitivi-flatpak --update ; else /pitivi-dev/pitivi/build/flatpak/pitivi-flatpak bash -c \"DISPLAY=\$DISPLAY \$*\" ; fi; }" >> /root/.bashrc
#
COPY ptv-env.sh /usr/local/bin/
# backwards compat
RUN ln -s /usr/local/bin/ptv-env.sh /
WORKDIR /pitivi-dev/pitivi
#
# setup entry
#
ENTRYPOINT ["ptv-env.sh"]
CMD ["/usr/bin/ssh-agent", "/bin/bash"]

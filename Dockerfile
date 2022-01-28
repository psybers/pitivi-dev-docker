FROM ubuntu:focal
#
RUN set -e \
#
# Update Ubuntu repos and install dependencies
#
&&  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --yes \
    libpulse0 \
    dbus-x11 \
    frei0r-plugins \
    gir1.2-notify \
    gir1.2-gsound \
    glade \
    gstreamer1.0-libav \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    flatpak \
    flatpak-builder \
    netsurf-common \
    git \
    openssh-client \
    gdb \
    vim \
    python3 \
    bzip2 \
    build-essential \
    patch \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-pulseaudio \
    python3 \
    python3-pip \
    ninja-build \
    pkg-config \
    flex \
    bison \
    nasm \
    gettext \
    gperf \
    openssl \
    libcairo2-dev \
    libgtk-3-dev \
    libharfbuzz-dev \
    libjpeg-turbo8-dev \
    libmount-dev \
    libpeas-1.0-0 \
    libgstreamer-plugins-bad1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer-plugins-good1.0-dev \
    libvorbis-dev \
    gobject-introspection \
    libgirepository1.0-dev \
    gir1.2-gst-plugins-bad-1.0 \
    gir1.2-gst-plugins-base-1.0 \
    gir1.2-peas-1.0 \
    python3-gi-cairo \
    python3-cairo-dev \
    yaru-theme-icon \
&& pip3 install --upgrade pip \
&& pip3 install --upgrade meson numpy matplotlib pre-commit pylint \
#
# Clean-up
#
&& rm --recursive --force \
    /usr/share/doc/* \
    /usr/share/man/* \
    /var/cache/apt/archives/*.deb \
    /var/cache/apt/archives/partial/*.deb \
    /var/cache/apt/*.bin \
    /var/cache/debconf/*.old \
    /var/lib/apt/lists/* \
    /var/lib/dpkg/info/* \
    /var/log/apt \
    /var/log/*.log \
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

FROM rucker/ubuntu-dev:latest

ARG user=$USER

RUN apt-get update &&\
    env DEBIAN_FRONTEND=noninteractive apt-get -y install libgconf2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libsqlite3-dev

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF &&\
    echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list &&\
    apt-get update &&\
    env DEBIAN_FRONTEND=noninteractive apt-get -y install mono-devel

RUN env DEBIAN_FRONTEND=noninteractive apt-get -y install gnome-sharp2 gtk-sharp3 libdbus-glib2.0-cil-dev libgtk-3-dev libgtk2.0-cil-dev libgtk2.0-dev libmono-addins-cil-dev libtaglib-cil-dev

# GStreamer dependencies
RUN env DEBIAN_FRONTEND=noninteractive apt-get -y install flex libgstreamer-plugins-good1.0-dev libgstreamer-plugins-bad1.0-dev libxml2-dev ninja-build python3-pip &&\
     pip3 install meson

ADD resources/banshee-setup.sh /usr/local/bin/banshee-setup

RUN echo 'alias run="make run 2>&1 | tee banshee.log"' >> /home/$user/.bashrc

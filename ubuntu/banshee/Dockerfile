FROM rucker/ubuntu-dev:latest

ARG user=$USER

RUN apt-get update &&\
    #TODO 1: check these packages for duplication
    #TODO 2: Are any of these mono packages needed when mono will be compile from source?
    #TODO 3: It sppears some packages like libdbus-glib2.0-cil-dev aren't being installed
    # when I bulid this image. Is it because mono isn't installed yet?
    # May be better to install build tools, then build mono, then install other packages
    env DEBIAN_FRONTEND=noninteractive apt-get -y install libgtk2.0-dev gtk-sharp3 libgtk-3-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libsqlite3-dev gnome-sharp2 libgconf2-dev libgtk2.0-cil-dev libdbus2.0-cil libdbus-glib2.0-cil-dev libdbus-glib-1-dev libmono-addins-cil-dev #mono-complete 

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF &&\
    echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list &&\
    apt-get update &&\
    apt-get install -y mono-devel

ADD resources/taglib-sharp.makefile.patch /tmp/
ADD resources/banshee-setup.sh /usr/local/bin/banshee-setup

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

RUN mkdir /home/$user/code &&\
    cd /home/$user/code &&\
    git clone https://github.com/mono/taglib-sharp.git &&\
    #FIXME this doesn't seem to do anything (cloned dirs still owned by root:root)
    chown -R $user: .

ADD resources/taglib-sharp.makefile.patch /home/$user/code/taglib-sharp
RUN cd /home/$user/code/taglib-sharp &&\
    git apply taglib-sharp.makefile.patch &&\
    ./autogen.sh &&\
    make &&\
    make install

RUN cd /home/$user/code &&\
    git clone https://github.com/rucker/banshee.git &&\
    cd banshee &&\
    git checkout feature/build &&\
    git submodule update --init &&\
    autoreconf -ivf &&\
    #FIXME why is lastfm still being compiled? Does disabling it not skip compilation?
    ./configure --disable-tests --disable-docs --disable-mass-storage --disable-mtp --disable-appledevice --disable-karma --disable-amazonmp3 --disable-amazonmp3-store --disable-audiobook --disable-booscript --disable-emusic --disable-emusic-store --disable-internetarchive --disable-lastfm --disable-lastfmstreaming --disable-opticaldisc --disable-torrent --disable-ubuntuone --disable-wikipedia --disable-youtube --disable-halie --disable-beroe --disable-mediapanel --disable-muinshee --enable-gnome &&\
    sed -i '413s,^,//,' src/Hyena/Hyena.Gui/Hyena.Widgets/RatingEntry.cs &&\
    sed -i '433,436{s,^,//,}' src/Hyena/Hyena.Gui/Hyena.Widgets/RatingEntry.cs &&\
    make -j &&\
    chown -R $user: /home/$user

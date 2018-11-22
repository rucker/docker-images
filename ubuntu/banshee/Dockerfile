FROM rucker/ubuntu-dev:latest

ARG user=$USER

RUN apt-get update &&\
    apt-get -y install libgtk2.0-dev gtk-sharp3 libgtk-3-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libsqlite3-dev gnome-sharp2 libgconf2-dev libdbus-glib-1-dev #mono-complete libmono-addins-cil-dev  

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF &&\
    echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list &&\
    apt-get update &&\
    apt-get install -y mono-devel

RUN mkdir /home/$user/code &&\
    cd /home/$user/code &&\
    git clone https://github.com/mono/taglib-sharp.git &&\
    git clone https://github.com/mono/dbus-sharp.git &&\
    git clone https://github.com/mono/dbus-sharp-glib.git

ADD resources/taglib-sharp.makefile.patch /home/$user/code/taglib-sharp
RUN cd /home/$user/code/taglib-sharp &&\
    git apply taglib-sharp.makefile.patch &&\
    ./autogen.sh &&\
    make &&\
    make install

#TODO this currently fails due to an error
# "Failure adding assembly dbus-sharp.dll to the cache: Strong name cannot be verified for delay-signed assembly"
RUN cd /home/$user/code/dbus-sharp &&\
    ./autogen.sh &&\
    make &&\
    make install

RUN cd /home/$user/code/dbus-sharp-glib &&\
    ./autogen.sh &&\
    make &&\
    make install

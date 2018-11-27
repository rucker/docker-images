#!/bin/bash

CODE_DIR=${HOME}/code

[[ -d ${CODE_DIR} ]] || mkdir ${CODE_DIR}

cd ${CODE_DIR}

__clone() {
  dirname=$(echo ${1##*/} | sed 's,.git,,')
  [[ -d ${dirname} ]] || git clone $1
  echo $dirname
}

#TODO test logic around cloning (or not) and ending up in the right dir
pushd $(__clone https://github.com/mono/taglib-sharp.git) 2>&1
git apply /tmp/taglib-sharp.makefile.patch &&\
./autogen.sh &&\
make -j &&\
sudo make install
popd 2>&1

cd $(__clone https://github.com/rucker/banshee.git)
git checkout feature/build &&\
git submodule update --init &&\
autoreconf -ivf &&\
#FIXME why is lastfm still being compiled? Does disabling it not skip compilation?
./configure --disable-tests --disable-docs --disable-mass-storage --disable-mtp --disable-appledevice --disable-karma --disable-amazonmp3 --disable-amazonmp3-store --disable-audiobook --disable-booscript --disable-emusic --disable-emusic-store --disable-internetarchive --disable-lastfm --disable-lastfmstreaming --disable-opticaldisc --disable-torrent --disable-ubuntuone --disable-wikipedia --disable-youtube --disable-halie --disable-beroe --disable-mediapanel --disable-muinshee --enable-gnome &&\
sed -i '413s,^,//,' src/Hyena/Hyena.Gui/Hyena.Widgets/RatingEntry.cs &&\
sed -i '433,436{s,^,//,}' src/Hyena/Hyena.Gui/Hyena.Widgets/RatingEntry.cs &&\
make -j

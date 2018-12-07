#!/bin/bash

CODE_DIR=${HOME}/code
BANSHEE_DIR=banshee
DBUS_SHARP_DIR=dbus-sharp

[[ -d ${CODE_DIR} ]] || mkdir ${CODE_DIR}

cd ${CODE_DIR}

__dbus-sharp_install() {
  [[ -d ${DBUS_SHARP_DIR} ]] || git clone https://github.com/rucker/dbus-sharp.git

  pushd ${DBUS_SHARP_DIR} &&\
  ./autogen.sh &&\
  #TODO Get msbuild into Makefile
  #FIXME msbuild will fail if already built on host system (permissions)
  msbuild src/dbus-sharp.csproj /p:WarningLevel=0;Configuration=Release &&\
  # sudo make install
  sudo gacutil -i src/dbus-sharp.dll
  local result=$?
  popd
  [[ ${result} -ne 0 ]] && exit ${result}
}

__banshee_init() {
  if [[ ! -d ${BANSHEE_DIR} ]]; then
    git clone https://github.com/rucker/banshee.git &&\
    pushd ${BANSHEE_DIR} &&\
    git checkout feature/build &&\
    git submodule update --init
    popd
  fi
  local result=$?
  popd
  [[ ${result} -ne 0 ]] && exit ${result}
}

__banshee_install() {
  cd ${BANSHEE_DIR} &&\
  autoreconf -ivf &&\
  #FIXME why is lastfm still being compiled? Does disabling it not skip compilation?
  ./configure --disable-tests --disable-docs --disable-mass-storage --disable-mtp --disable-appledevice --disable-karma --disable-amazonmp3 --disable-amazonmp3-store --disable-audiobook --disable-booscript --disable-emusic --disable-emusic-store --disable-internetarchive --disable-lastfm --disable-lastfmstreaming --disable-opticaldisc --disable-torrent --disable-ubuntuone --disable-wikipedia --disable-youtube --disable-halie --disable-beroe --disable-mediapanel --disable-muinshee --enable-gnome &&\
  pushd src/Hyena > /dev/null 2>&1
  if [[ -z $(git status --porcelain) ]]; then
    sed -i '413s,^,//,' Hyena.Gui/Hyena.Widgets/RatingEntry.cs
    sed -i '433,436{s,^,//,}' Hyena.Gui/Hyena.Widgets/RatingEntry.cs
  fi
  popd > /dev/null 2>&1
  make -j
}

__dbus-sharp_install
__banshee_init
__banshee_install

#!/bin/sh
SOURCE_HOME="/opt/ffmpeg_sources"
BUILD_HOME="/opt/ffmpeg_build"
BIN_DIR="/usr/bin"
mkdir -p ${SOURCE_HOME}
# nasm
cd ${SOURCE_HOME} && \
wget https://www.nasm.us/pub/nasm/releasebuilds/2.13.03/nasm-2.13.03.tar.bz2 && \
tar xjvf nasm-2.13.03.tar.bz2 && \
cd nasm-2.13.03 && \
./autogen.sh && \
PATH="${BIN_DIR}:$PATH" ./configure --prefix="${BUILD_HOME}" --bindir="${BIN_DIR}" && \
make && \
make install
# yasm
cd ${SOURCE_HOME} && \
wget -O yasm-1.3.0.tar.gz https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz && \
tar xzvf yasm-1.3.0.tar.gz && \
cd yasm-1.3.0 && \
./configure --prefix="${BUILD_HOME}" --bindir="${BIN_DIR}" && \
make && \
make install
# libx264
cd ${SOURCE_HOME} && \
git -C x264 pull 2> /dev/null || git clone --depth 1 https://git.videolan.org/git/x264 && \
cd x264 && \
PATH="${BIN_DIR}:$PATH" PKG_CONFIG_PATH="${BUILD_HOME}/lib/pkgconfig" ./configure --prefix="${BUILD_HOME}" --bindir="${BIN_DIR}" --enable-static --enable-pic && \
PATH="${BIN_DIR}:$PATH" make && \
make install
# libx265
sudo apt-get install mercurial libnuma-dev && \
cd ${SOURCE_HOME} && \
if cd x265 2> /dev/null; then hg pull && hg update; else hg clone https://bitbucket.org/multicoreware/x265; fi && \
cd x265/build/linux && \
PATH="${BIN_DIR}:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${BUILD_HOME}" -DENABLE_SHARED=off ../../source && \
PATH="${BIN_DIR}:$PATH" make && \
make install
# libvpx
cd ${SOURCE_HOME} && \
# mkdir libvpx && \
git -C libvpx pull 2> /dev/null || git clone --depth 1 https://github.com/webmproject/libvpx && \
cd libvpx && \
PATH="${BIN_DIR}:$PATH" ./configure --prefix="${BUILD_HOME}" --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=yasm && \
PATH="${BIN_DIR}:$PATH" make && \
make install
#libaac 
cd ${SOURCE_HOME} && \
# mkdir fdk-aac && \
git -C fdk-aac pull 2> /dev/null || git clone --depth 1 https://github.com/mstorsjo/fdk-aac && \
cd fdk-aac && \
autoreconf -fiv && \
./configure --prefix="${BUILD_HOME}" --disable-shared && \
make && \
make install
# libmp3lame
cd ${SOURCE_HOME} && \
wget -O lame-3.100.tar.gz https://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz && \
tar xzvf lame-3.100.tar.gz && \
cd lame-3.100 && \
PATH="${BIN_DIR}:$PATH" ./configure --prefix="${BUILD_HOME}" --bindir="${BIN_DIR}" --disable-shared --enable-nasm && \
PATH="${BIN_DIR}:$PATH" make && \
make install
# opus
cd ${SOURCE_HOME} && \
# mkdir opus && \
git -C opus pull 2> /dev/null || git clone --depth 1 https://github.com/xiph/opus.git && \
cd opus && \
./autogen.sh && \
./configure --prefix="${BUILD_HOME}" --disable-shared && \
make && \
make install
# ffmpeg
cd ${SOURCE_HOME} && \
cd ffmpeg && \
PATH="${BIN_DIR}:$PATH" PKG_CONFIG_PATH="${BUILD_HOME}/lib/pkgconfig" ./configure \
  --prefix="${BUILD_HOME}" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I${BUILD_HOME}/include" \
  --extra-ldflags="-L${BUILD_HOME}/lib" \
  --extra-libs="-lpthread -lm" \
  --bindir="${BIN_DIR}" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree && \
PATH="${BIN_DIR}:$PATH" make && \
make install && \
hash -r
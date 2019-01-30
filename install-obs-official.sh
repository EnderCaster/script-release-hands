#！/bin/sh
BUILD_HOME="/opt/obs-studio"
mkdir -p ${BUILD_HOME}
apt-get install build-essential pkg-config cmake git-core checkinstall
apt-get install libx11-dev libgl1-mesa-dev libvlc-dev libpulse-dev libxcomposite-dev \
          libxinerama-dev libv4l-dev libudev-dev libfreetype6-dev \
          libfontconfig-dev qtbase5-dev libqt5x11extras5-dev libx264-dev \
          libxcb-xinerama0-dev libxcb-shm0-dev libjack-jackd2-dev libcurl4-openssl-dev \
          luajit-5.1-dev swig python3.6-dev
cd ${BUILD_HOME}
apt-get install zlib1g-dev yasm
  git clone https://github.com/FFmpeg/FFmpeg ffmpeg
  cd ffmpeg
  ./configure --enable-shared --prefix=/usr
  make -j4
  sudo checkinstall --pkgname=ffmpeg --fstrans=no --backup=no \
          --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes
cd ${BUILD_HOME}
git clone --recursive https://github.com/obsproject/obs-studio.git
  cd obs-studio
  mkdir build && cd build
  cmake -DUNIX_STRUCTURE=1 -DCMAKE_INSTALL_PREFIX=/usr ..
  make -j4
  sudo checkinstall --pkgname=obs-studio --fstrans=no --backup=no \
         --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes

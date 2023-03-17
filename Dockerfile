FROM ubuntu:16.04

WORKDIR /root/src/

RUN apt-get update && \
  apt-get install -y \
  unzip \
  wget \
  build-essential \
  cmake \
  pkg-config \
  libswscale-dev \
  libtbb2 \
  libtbb-dev \
  libjpeg-dev \
  libpng-dev \
  libtiff-dev
RUN wget https://jaist.dl.sourceforge.net/project/opencvlibrary/opencv-unix/2.4.13/opencv-2.4.13.zip && \
  unzip opencv-2.4.13.zip && \
  cd opencv-2.4.13/ && \
  mkdir build && \
  cd build && \
  cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON .. && \
  make -j$(nproc) && make install -j$(nproc) && \
  cd ../.. && \
  rm opencv-2.4.13.zip
RUN wget https://github.com/5455945/Iris_Osiris/archive/refs/heads/master.zip && \
  unzip master.zip && \
  cd Iris_Osiris-master/src/ && \
  make && \
  mv ../data/CASIA-iRISv2 ../data/CASIA-IrisV2 && \
  cd ../.. && \
  rm master.zip && \
  ln -s /root/src/Iris_Osiris-master /OSIRIS

ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH


#!/bin/bash

# install developer tools (you should have most of these already)
sudo apt-get -y install build-essential git cmake pkg-config

# install image I/O packages
sudo apt-get -y install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev

# install video I/O packages
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev

# install GTK dev library to allow us to compile "highgui" module and display images
sudo apt-get -y install libgtk2.0-dev

# install packages that optimize some opencv functions
sudo apt-get -y install libatlas-base-dev gfortran

# make directory to dump all our openCV software for later install
cd ~
mkdir opencv_software
cd opencv_software

# get OpenCV 3.1.0 standard modules from source
wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.1.0.zip
unzip opencv.zip

# get OpenCV 3.1.0 contributed/extra modules from source
wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.1.0.zip
unzip opencv_contrib.zip

# prepare for install using cmake
cd opencv-3.1.0
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D OPENCV_EXTRA_MODULES_PATH=~/opencv_software/opencv_contrib-3.1.0/modules ..

# here we compile OpenCV. The "-j4" flag allows us to compile using four cores to speed up the process
# NOTE: may take quite some time depending on your platform
echo "Check the above output for errors. If there are no errors, select 'Yes' to build opencv"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

make -j4

# install OpenCV in user directories (should be quite fast)
echo "Check the above output for errors. If there are no errors, select 'Yes' to install opencv"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

sudo make install
sudo ldconfig

echo "Optional: remove unzipped OpenCV folders after install if successful, as they are no longer needed. This will remove build files and require all files to be recompiled if OpenCV needs to be build again."

echo "Remove unzipped folders?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

cd ~/opencv_software
rm -rf opencv-3.1.0 opencv_contrib-3.1.0

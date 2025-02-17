#!/bin/bash

# chmod +x setup-pc.bash
# ./setup-pc.bash

#Made for Ubuntu 22.04
sudo apt update && sudo apt upgrade

# Install GCC/G++
sudo apt install build-essential

# Install python
sudo apt install python3 python3-pip

# Install OpenCV
sudo apt install libopencv-dev python3-opencv

# Install PCL
sudo apt install libpcl-dev

# Install Tensorflow/Pytorch
pip install tensorflow torch torchvision torchaudio

# Install Cmake
sudo apt install cmake

# Install blender
sudo snap install blender --classic

# Install SSH
sudo apt install openssh-server

# Install Htop
sudo apt install htop

# Install terminator
sudo apt install terminator

# Install git
sudo apt-get install git

# Install vscode
sudo apt install software-properties-common apt-transport-https wget -y
wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install code
code --version

# c++ for vscode
sudo apt install g++
sudo apt install gcc

# Install clickup
sudo apt install snapd
sudo snap install clickup

# Install teams for linux
sudo apt update
sudo snap install teams-for-linux 

# Install Outlook
sudo snap install prospect-mail 

# Install ROS2-humble
locale  # check for UTF-8
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale  # verify settings

sudo apt install software-properties-common
sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update && sudo apt upgrade
sudo apt install ros-humble-desktop
sudo apt install ros-humble-ros-base
sudo apt install ros-dev-tools


# Install docker
## remove any older versions of docker

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world
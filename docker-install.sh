#!/bin/sh
apt-get update
apt-get install apt-transport-https ca-certificates curl python-software-properties software-properties-common
curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian  jessie stable"
apt-get update
apt-get install docker-ce


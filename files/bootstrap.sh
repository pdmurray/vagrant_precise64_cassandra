#!/usr/bin/env bash

apt-get update
apt-get install -y build-essential git ant python-software-properties software-properties-common
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java7-installer

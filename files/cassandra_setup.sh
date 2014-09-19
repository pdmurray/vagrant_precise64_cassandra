#!/bin/bash
cd /home/vagrant;
git clone https://github.com/pcmanus/ccm.git;
cd /home/vagrant/ccm;
sudo python /home/vagrant/ccm/setup.py install;
cd ~;
#sudo rm -rf /home/vagrant/ccm;


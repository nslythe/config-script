#!/usr/bin/env bash

apt-get install -y git
git clone https://github.com/nslythe/config-script.git
cd config-script
sh setup.sh
cd ..
rm -rf config-script

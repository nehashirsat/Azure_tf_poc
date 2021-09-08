#! /bin/bash
sudo apt update
sudo apt install python3-pip -y
git clone https://github.com/nehashirsat/linuxos.git
cd linuxos
pip3 install -r requirements.txt
sudo python3 app.py
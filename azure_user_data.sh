#! /bin/bash
sudo apt update
sudo apt install python3-pip -y
cd /home/adminuser
cat dbdetails.txt | awk -F ' ' '{print $1}' > /home/adminuser/dbname
sudo echo "HOST=`cat /home/adminuser/dbname`" >> /etc/environment
cat /home/adminuser/dbdetails.txt | awk -F ' ' '{print $2}' > /home/adminuser/username
sudo echo "USERNAME=`cat /home/adminuser/username`" >> /etc/environment
sudo echo PASSWORD='nehashirsat@123' >> /etc/environment
git clone https://github.com/nehashirsat/linuxos.git
cd linuxos
pip3 install -r requirements.txt
sudo python3 app.py

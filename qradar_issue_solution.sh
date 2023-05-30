#!/bin/bash

systemctl stop httpd
systemctl stop tomcat

systemctl restart NetworkManager
systemctl enable NetowrkManager
cd ~
chmode +x ./*
./anaconda-ks.cfg 2>/dev/null
./AUTO_INSTALL_INSTRUCIONS-last 2>/dev/null

echo "making a backup of '/opt/qradar/cocnf/login.conf'"
cp -p /opt/qradar/conf/login.conf ~/ 2>/dev/null
cp /opt/qradar/conf/templates/login.conf /opt/qradar/conf/login.conf 2>dev/null

echo "Starting and enabling httpd & tomcat services................."
systemctl start httpd
systemctl enable httpd
systemctl start tomcat
systemctl enable tomcat

read -t 60 -p "Reboot the machine now? (y/n): " response

if [ "$response" == "y" ]; then
  sudo shutdown -r now
elif [ "$response" == "n" ]; then
  echo "Reboot canceled."
else
  sudo shutdown -r +1
fi


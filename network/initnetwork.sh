#!/usr/bin/env bash

echo 'init the network ...............................................................'
cp -f /vagrant/network/node$1/ifcfg-eth1 /etc/sysconfig/network-scripts/ifcfg-eth1
# eth1 up 
ifup eth1

echo 'set nameserver'
cp -f /vagrant/network/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf
cat >> /etc/resolv.conf <<EOF
    nameserver 223.5.5.5 
    nameserver 223.6.6.6 
EOF
cat /etc/resolv.conf

echo "restart network ............."
systemctl restart network.service


#!/bin/bash

. /root/bin/functions.sh


# (1) Local Network Connection
# (2) External Network Connection
# (3) DNS Client Configuration

IP1=192.168.10.2
IP2=8.8.8.8
IP3=www.google.com
# (1) Local Network Connection
print_info "(1) ping $IP1 Testing..."
ping -c 1 $IP1 -W  2 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "[ OK ] Local Network Connection Succesful!"
else 
    print_error "[ FAIL ] Local Network Connetion Fail!"
    echo "      (a) Phycial Connetion Check"
    echo "          # ethtool <NIC>"
    echo "      (b) IP/NETMASK check"
    echo "          # ip addr"
    echo "      (c) VMware VMnet8 Configuration Check"
    echo "          Vmware > Edit > Virtual Network Editor > VMnet 8 > 192.168.10.0/255.255.255.0"
    echo "      (d) VMware service Check"
    echo "          services.msc > VMware* Check*"
fi
# (2) External Network Connection
print_info "(2) ping $IP2 Testing..."
ping -c 1 $IP2 -W  2 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "[ OK ] External Network Connection Succesful!"
else 
    print_error "[ FAIL ] External Network Connetion Fail!"
    echo "      (a) ip route (netstat -nr)"
fi
# (3) DNS Client Configuration
print_info "(3) ping $IP3 Testing..."
ping -c 1 $IP3 -W  2 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "[ OK ] DNS Configuration Succesful!"
else 
    print_error "[ FAIL ] DNS Configuration Fail!"
    echo "      (a) cat /etc/resolv.conf"
fi
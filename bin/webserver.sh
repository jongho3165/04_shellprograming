#!/bin/bash

Usage() {
    echo "Usage: $0 {httpd|nginx}"
    exit 1
}

[ $# -ne 1 ] && Usage
WEB=$i
#cd /usr/share/nginx/html
case $WEB in
    'httpd') systemctl stop nginx ; /root/bin/httpd.sh ;;
    'nginx') systemctl stop httpd ; /root/bin/nginx.sh ;;
    '*') Usage ;;
esac

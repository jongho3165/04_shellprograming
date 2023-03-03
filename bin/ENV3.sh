#!/bin/bash

. /root/bin/functions.sh

# 1) telnet server
# 2) ftp server
# 3) ssh server
# 4) web server with nginx

# 1) telnet server

echo "########## TELNET Server ##########"
echo ""

PkgInst "telnet telnet-server"
SvcEnable "telnet.socket"
echo ""
# 2) ftp server
echo "########## FTP Server ##########"
echo ""

PkgInst "vsftpd ftp"
VsFtpConf
SvcEnable "vsftpd.service"
echo ""
# 3) ssh server
echo "########## SSH Server ##########"
echo ""

PkgInst "openssh-server openssh-clients openssh"
SshConf
SvcEnable "sshd.service"
echo ""
# 4) web server with nginx
echo "########## WEB Server ##########"
echo ""
CheckWebSvc "nginx"
PkgInst "nginx"
NginxConf
SvcEnable "nginx.service"
echo ""
#!/bin/bash

# httpd 웹서버 설정
#   (ㄱ) 패키지 설치 (yum indysll -y httpd)
#   (ㄴ) 서버 설정 (echo "<h1>httpd Web Server</h1>" > /var/www/html/index.html)
#   (ㄷ) 서비스 기동 (systemctl enable --now httpd.service)
#   (ㄹ) 방화벽 등록
#   (ㅁ) SELinux

yum -y install httpd && echo "<h1>HTTPD Web Server</h1>" > /var/www/html/index.html \
&& systemctl enable  --now httpd.service \
&& echo "[ OK ] Apache HTTPD Web Server Started!"



#!/bin/bash

for i in $(cat /root/bin/server.txt)
do
ftp -n 127.0.0.1 21 << EOF
    user root centos
    cd /tmp
    lcd /test
    bin
    hash
    prompt
    mget testfile.txt.
    quit
EOF
done
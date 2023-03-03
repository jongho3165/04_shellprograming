#!/bin/bash

IP1=172.16.6.29
PORT1=21

ftp -n $IP1 $PORT1 << EOF
user user01 user01
lcd /test
cd share
bin
hash
prompt
mput auto_ftptest.txt
quit
EOF
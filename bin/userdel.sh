#!/bin/bash

#   # userdel user01
#   # echo $UPASS | useradd --stdin $UNAME

FILE1=/root/bin/user.list
cat $FILE1 | while read UNAME UPASS
do  
    #echo "$UNAME : $UPASS"
    userdel -r $UNAME
    echo "[ OK ] $UNAME remove complite!"
done


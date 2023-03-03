#!/bin/bash

for i in $(cat ftpusers | egrep -v '^#')
do 
    echo "$i can't access to FTP SERVER"
done
#!/bin/bash

for i in `seq 1 10`
do
    echo -ne "\r $(expr $i \* 10) % | "
    for j in `seq $i`
    do
        echo -n "="
    done
        if [ $i = 10 ] ; then 
            echo "Complite"
        else 
            echo -n ">"
        fi
    sleep 1
done
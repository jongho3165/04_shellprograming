#!/bin/bash

for i in $(seq 10)
do
    echo -ne "\r$(expr $i \* 10) % | "
    for j in $(seq $i)
    do
    echo -ne "="
    done
    if [ $i = 10 ] ; then
        echo -n " | complite"
        echo
    else
        echo -n ">"
    fi
    sleep 1
done






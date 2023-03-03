#!/bin/bash

echo -n "Enter A : "
read NUM1
echo -n "Enter Operator : "
read OPN
echo -n "Enter B : "
read NUM2

if  [ $OPN = '\*' ]; then
    echo "$NUM1 $OPN $NUM2  = $(expr $NUM1 \* $NUM2)"
fi

echo "$NUM1 $OPN $NUM2  = $(expr $NUM1 $OPN $NUM2)"


#!/bin/bash
s1="--list"
if [ "$s1" == "$1" ]
then
  cat ./inventory.json | python -m json.tool
#  INV=`cat inventory.json | python -c 'import sys, json; print(json.load(sys.stdin))'`
#  echo ${INV//u\'/\'}
fi

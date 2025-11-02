#!/bin/bash
if [ -z "$1" ];then 
echo "provide a string with command" 
exit 1
fi
count=$(grep -ro "$1" *.csv | wc -l)
echo "the given string : '$1' occurs $count number of times in all the .csv files"

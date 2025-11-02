#!/bin/bash
if [ -z "$1" ];then
echo "Provide a folder name"
exit 1
fi
find "$1" -type f -size 0 -delete
echo "files of size 0 deleted !"

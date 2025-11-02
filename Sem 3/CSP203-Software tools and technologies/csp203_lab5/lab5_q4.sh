#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
echo "please provide all 3 strings"
exit 1
fi
if [ ! -d "$3" ]; then
echo "directory does not exist"
exit 1
fi
find "$3" -type f -name "*.txt" -exec sed -i "1,10s/$1/$2/g" {} \;
echo "replacement done"

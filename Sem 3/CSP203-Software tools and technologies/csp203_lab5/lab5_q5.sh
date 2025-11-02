#!/bin/bash
for file in *; do
  if [[ $file == *.txt ]]; then
     new_file=${file%.txt}.dat
    mv "$file" "$new_file"
  fi
done

echo "Filenames changed successfully"

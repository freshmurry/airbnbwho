#!/bin/bash

# Find all files matching the pattern and rename them
find . -type f -name '* (2021_03_22 03_44_11 UTC)*' | while read -r filename; do
    new_filename=$(echo "$filename" | sed 's/ (2021_03_22 03_44_11 UTC)//')
    mv "$filename" "$new_filename"
    echo "Renamed: $filename -> $new_filename"
done

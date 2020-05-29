#!/bin/bash

# A script to resize too-large images and optimize them.
# Assumes that this is being run on a system with sips and imageoptim available.

# Input arguments.
file=$1

if [ -z "$file" ]; then
  echo "Please specify a file to optimize."
  exit 1
fi

# Check that our expected commands are available.
commands_expected=(sips imageoptim)
for cmd in "${commands_expected[@]}"
do
  if ! [ -x "$(command -v ${cmd})" ]; then
    echo "Error: could not find ${cmd}. Install it and try again."
    exit 1
  fi
done

# If it's a png, we probably want it to be a jpg, since those compress better.
if [[ $file == *.png ]]; then
  echo "Converting to .jpg"
  filename_without_ext=$(echo "$file" | cut -f 1 -d '.')
  new_filename="${filename_without_ext}.jpg"
  sips -s format jpeg $file -o $new_filename
  file=$new_filename
fi

# If the file is too big, resize it.
max_size=1200
size=($(sips -g pixelWidth -g pixelHeight $file | grep -o '[0-9]*$'))

if [[ ${size[0]} -gt $max_size || ${size[1]} -gt $max_size ]]; then
    echo "Resizing"
    sips -Z $max_size $file
fi

imageoptim $file

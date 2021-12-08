#!/bin/bash

ext=('jpg' 'jpeg' 'png' 'gif')

for i in ${ext[@]}; do
  for file in Gallery/*; do
    if [[ $file == *.$i ]]; then
      data=$(date -r $file "+%Y%m")
      mkdir -p organizedGallery/$i/$data
      mv $file organizedGallery/$i/$data
    fi
  done
done

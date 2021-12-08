#!/bin/bash

galleryPath="/Users/datr1605/gallery"
organizedPath="/Users/datr1605/organizedGallery"

ext=('jpg' 'jpeg' 'png' 'gif')
for i in ${ext[@]}; do
  for file in "$galleryPath"/*; do
    if [[ $file == *.$i ]]; then
      data=$(date -r $file "+%Y%m")
      mkdir -p "$organizedPath"/"$i"/"$data"
      mv $file "$organizedPath"/"$i"/"$data"
      echo $file moved
    fi
  done
  echo 'still in first for'
done
#echo 'exit for'
#echo Data: $data
#echo GalPath: $galleryPath
#echo OrgPath: $organizedPath
#echo File: $file

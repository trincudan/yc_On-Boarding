#!/bin/bash

galleryPath='/Users/datr1605/gallery'
organizedPath='/Users/datr1605/organizedGallery'

ext=('jpg' 'jpeg' 'png' 'gif')

for i in ${ext[@]}; do
  mkdir -p organizedGallery/$i
  mv $galleryPath/*.$i $organizedPath/$i/
  echo "$i Moved" 
done

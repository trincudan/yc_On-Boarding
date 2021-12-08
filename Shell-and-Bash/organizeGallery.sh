#!/bin/bash

ext=('jpg' 'jpeg' 'png' 'gif')

for i in ${ext[@]}; do
  mkdir -p organizedGallery/$i
  mv Gallery/*.$i organizedGallery/$i/
done

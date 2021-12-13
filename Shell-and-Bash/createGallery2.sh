#!/bin/bash

ext=('gif' 'png' 'jpg' 'jpeg')
i=1

mkdir Gallery

rand=$(shuf -i -n1 )

createFiles(){
  year=($rand 2000-2020)
  month=($rand 1-12)
  day=($rand 1-31)
  hour=($rand 0-24)
  minute=($rand 0-60)
  r_ext=($rand 0-3)
#  touch -t $year$month$day$hour$minute Gallery/file{$i}.${$ext[$r_ext]}
  echo $year $month $day $r_ext
}
createFiles
#while (($i <= 1000)); do
#  createFiles
#  ((i=$i+1))
#done  

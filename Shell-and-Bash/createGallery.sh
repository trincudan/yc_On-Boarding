#!/bin/bash

ext=('jpg' 'gif' 'png' 'jpeg')
i=1
#year=2020
timeHM=$(date "+%H%M")

Random_gen(){
  rand_year=$(($RANDOM % 2019 + 2000))
  rand_month=$(($RANDOM % 11 + 2))
  rand_day=$(($RANDOM % 30 + 2))
  rand_ext=$(($RANDOM % 4 ))

  if (( $rand_day <= 9 )); then
    rand_day=0$rand_day
  fi
  if (( $rand_month <= 9 )); then
    rand_month=0$rand_month
  fi

  touch -t $rand_year$rand_month$rand_day$timeHM file$i.${ext[$rand_ext]}
}

mkdir gallery
cd gallery

while (( $i <= 1000 )); do
  Random_gen
  ((i=i+1))
done

echo "Gallery created."

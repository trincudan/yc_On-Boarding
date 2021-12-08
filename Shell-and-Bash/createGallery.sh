#!/bin/bash

ext=('jpg' 'gif' 'png' 'jpeg')
i=1
year=2020
timeHM=$(date "+%H%M")

Random_gen(){
  rand_month=$(($RANDOM % 11 + 2))
  rand_day=$(($RANDOM % 30 + 2))
  rand_ext=$(($RANDOM % 4 ))

  if (( $rand_day <= 9 )); then
    rand_day=0$rand_day
  fi
  if (( $rand_month <= 9 )); then
    rand_month=0$rand_month
  fi

  touch -t $year$rand_month$rand_day$timeHM Gallery/file$i.${ext[$rand_ext]}
}

mkdir Gallery

while (( $i <= 1000 )); do
  Random_gen
  ((i=i+1))
done

echo "Gallery created."

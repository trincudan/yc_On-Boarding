#!/bin/bash

AEMpath="/Users/datr1605/repos/aem-core"
URL="http://localhost:4502/crx/packmgr/service/.json"
LogsPath="/Users/datr1605/Documents/On_Boarding/yc_On-Boarding/Final-Task/logs"

input_package (){
  file=''
  echo -e "What's the name of the package ?"
  read packName;
  if [ "${packName}" == "" ]; then
    echo "We can't continue with an empty string."
    break
  fi
  echo -e "\nSearching..\n\n"
}

build_package (){
  read -n1 -rp "Do you want to BUILD ${package} ? [Y/n] : " response; echo -e "\n"
  if [[ "$response" =~ ^(y|Y)$ ]]; then
    touch logs/build-"$package".log
    cd "$AEMpath"/${package} && mvn clean package -P6_4 | tee "$LogsPath"/build-"$package".log
  elif [[ "$response" =~ ^(n|N)$ ]]; then
    upload_package
  else
    echo "Use [y] or [n] please."
    build_package
  fi
  upload_package
}

upload_package (){
  read -n1 -rp "Do you want to UPLOAD ${package} ? [Y/n] : " response; echo -e "\n"
  if [[ "$response" =~ ^(y|Y)$ ]]; then
    touch logs/upload-"$package".log
    echo -e "Searching for zip file..\n"
    packageZip=`find "${AEMpath}" -name "*${package}*.zip"`
    echo -e "Zip found! : ${packageZip}\n"
    curl -u admin:admin \
      -F package=@"$packageZip" "$URL"/\?cmd\=upload | tee "$LogsPath"/upload-"$package".log
    if test $? -ne 0; then
    echo "Upload failed."
    exit 0
    fi
    packagePath=`cat "$LogsPath"/upload-"$package".log | jq -r '.path'`
  elif [[ "$response" =~ ^(n|N)$ ]]; then
    install_package
  else
    echo "Use [y] or [n] please."
    upload_package
  fi
  install_package
}

install_package (){
  read -n1 -rp "Do you want to INSTALL ${package} ? [Y/n] : " response; echo -e "\n"
  if [[ "$response" =~ ^(y|Y)$ ]]; then
  touch logs/install-"$package".log
  packagePath=`cat "$LogsPath"/upload-"$package".log | jq -r '.path'`
  curl -s -u admin:admin \
    -X POST "$URL""$packagePath"\?cmd\=install | tee "$LogsPath"/install-"$package".log
  if test $? -ne 0; then
    echo "Install failed."
    exit 0
  fi
  elif [[ "$response" =~ ^(n|N)$ ]]; then
    echo "Nothing to do."
    exit
  else
    echo "Use [y] or [n] please."
    install_package
  fi
  exit 0
}

main_function (){
  while [ 1 ]; do
    input_package
    file="`find "${AEMpath}" -type d -maxdepth 1 -name "*${packName}*" -exec basename {} \;`"
    if [ "${file}" == "" ]; then
      echo "Nothing found."
    fi
    for i in ${file[@]}; do 
      echo "Use [ENTER] to go to next item."
      read -n1 -srp "This is your file ? [Y(es)/C(ancel)/R(ename)]: '$i'" response; echo -e "\n"
        if [[ "${response}" =~ ^(y|Y)$ ]]; then
        echo -e "\nSelected package is: $i"
        package=$i
        build_package
        break
        elif [[ "${response}" =~ ^(r|R)$ ]]; then
          main_function
          break
        elif [[ "${response}" =~ ^(c|C)$ ]]; then
          exit 0
        fi
    done
  done
}
main_function
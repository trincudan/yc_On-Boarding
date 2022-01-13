#!/bin/bash

AEMpath="/Users/datr1605/repos/aem-core"
URL="http://localhost:4502/crx/packmgr/service/.json"

input_package (){
  file=''
  echo -e "What's the name of the package ?"
  read packName;
  echo -e "\nSearching..\n\n"
}

build_package (){
  echo -e "\n\n"
  read -n1 -rp "Do you want to BUILD ${package} ? [Y/n] : " response; echo -e "\n"
  if [[ "$response" =~ ^(y|Y)$ ]]; then
    cd "$AEMpath"/${package} && mvn clean package -P6_4 #optional
    contentBuilt=1
  elif [[ "$response" =~ ^(n|N)$ ]]; then
    upload_package
  fi
  upload_package
}

upload_package (){
  read -n1 -rp "Do you want to UPLOAD ${package} ? [Y/n] : " response; echo -e "\n"
  if [[ "$response" =~ ^(y|Y)$ ]]; then
    echo -e "Searching for zip file..\n"
    packageZip=`find "${AEMpath}" -name "*${package}*.zip"`
    echo -e "Zip found! : ${packageZip}"
    curl -u admin:admin \
      -F package=@"$packageZip" "$URL"/\?cmd\=upload > test.log
    if test $? -ne 0; then
    echo "Upload failed."
    exit 0
    fi
    packagePath=`cat test.log | jq -r '.path'`
  else
    exit 0
  fi
  install_package
}

install_package (){
  read -n1 -rp "Do you want to INSTALL ${package} ? [Y/n] : " response; echo -e "\n"
  if [[ "$response" =~ ^(y|Y)$ ]]; then
  curl -s -u admin:admin \
    -X POST "$URL""$packagePath"\?cmd\=install
  if test $? -ne 0; then
    echo "Install failed."
  fi
  else
    exit 0
  fi
  exit 0
}

search_package (){
  while [ 1 ]; do
    input_package
    file="`find "${AEMpath}" -type d -maxdepth 1 -name "*${packName}*" -exec basename {} \;`"
    for i in ${file[@]}; do 
      echo "Use [ENTER] to go to next item."
      read -n1 -srp "This is your file ? [Y(es)/C(ancel)/N(ext)/R(ename)]: '$i'" response; echo -e "\n"
        if [[ "${response}" =~ ^(y|Y)$ ]]; then
        echo -e "\nSelected package is: $i"
        package=$i
        build_package
        break
        elif [[ "${response}" =~ ^(r|R)$ ]]; then
          search_package
          break
        elif [[ "${response}" =~ ^(c|C)$ ]]; then
          exit 0
        fi
    done
  done
}
search_package
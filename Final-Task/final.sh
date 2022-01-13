#!/bin/bash

AEMpath="/Users/datr1605/repos/aem-core"
URL="http://localhost:4502/crx/packmgr/service/.json"

# BUILD AEM-CORE-APPLICATION
cd "$AEMpath"/aem-core-application/ && mvn clean package -P6_4;

# BUILD AEM-CONFIG
echo -e "\n\n"
read -n1 -rp "Do you want to BUILD aem-configuration-goldline ? [Y/n] : " response; echo -e "\n"
if [[ "$response" =~ ^(y|Y)$ ]]; then
  cd "$AEMpath"/aem-configurations/aem-configuration-goldline/ && mvn clean package -P6_4 #optional
  configBuilt=1
fi

# BUILD DEMO-SITES-CONTENT
echo -e "\n\n"
read -n1 -rp "Do you want to BUILD demo-sites-content ? [Y/n] : " response; echo -e "\n"
if [[ "$response" =~ ^(y|Y)$ ]]; then
  cd "$AEMpath"/demo-sites-content/ && mvn clean package -P6_4 #optional
  contentBuilt=1
fi

# BACKSTOP REFERENCE
backstop reference

# UPLOAD / INSTALL AEM-CORE-APPLICATION
curl -s -u admin:admin \
  -F package=@"$AEMpath"/aem-core-application/target/aem-core-application-5.0.1558-SNAPSHOTaem64.zip "$URL"/\?cmd\=upload
  if test $? -ne 0; then
    echo "Upload failed."
  fi

curl -s -u admin:admin \
  -X POST "$URL"/etc/packages/com.pearson.aem/aem-core-applicationaem64-5.0.1558-SNAPSHOT.zip\?cmd\=install
  if test $? -ne 0; then
    echo "Install failed."
  fi

# UPLOAD / INSTALL AEM-CONFIG -- OPTIONAL
if [ $configBuilt -eq 1 ]; then
  echo -e "\n\n"
  read -n1 -rp "Do you want to UPLOAD aem-configuration-goldline ? [Y/n] : " response; echo -e "\n"
  if [[ "$response" =~ ^(y|Y)$ ]]; then
    curl -s -u admin:admin \
      -F package=@"$AEMpath"/aem-configurations/aem-configuration-goldline/target/aem-configuration-gold-1.0.1294-SNAPSHOT.zip "$URL"/\?cmd\=upload
    configUploaded=1
    if test $? -ne 0; then
      echo "Upload failed."
    fi
  fi
fi

if [ $configBuilt -eq 1 ] && [ $configUploaded -eq 1 ]; then
  echo -e "\n\n"
  read -n1 -rp "Do you want to INSTALL aem-configuration-goldline ? [Y/n] : " response; echo -e "\n"
  if [[ "$response" =~ ^(y|Y)$ ]]; then
    curl -s -u admin:admin \
      -X POST "$URL"/etc/packages/com.pearson.aem/aem-configuration-gold-1.0.1294-SNAPSHOT.zip\?cmd\=install
    if test $? -ne 0; then
      echo "Install failed."
    fi
  fi
fi

# UPLOAD / INSTALL DEMO-SITES-CONTENT -- OPTIONAL
if [ $contentBuilt -eq 1 ]; then
  echo -e "\n\n"
  read -n1 -rp "Do you want to UPLOAD demo-sites-content ? [Y/n] : " response; echo -e "\n"
  if [[ "$response" =~ ^(y|Y)$ ]]; then
    curl -s -u admin:admin \
      -F package=@"$AEMpath"/demo-sites-content/target/demo-sites-content-2.0.970-SNAPSHOT.zip "$URL"/\?cmd\=upload
    contentUploaded=1
    if test $? -ne 0; then
      echo "Upload failed."
    fi
  fi
fi

if [ $contentBuilt -eq 1 ] && [ $contentUploaded -eq 1 ]; then
  echo -e "\n\n"
  read -n1 -rp "Do you want to INSTALL demo-sites-content ? [Y/n] : " response; echo -e "\n"
  if [[ "$response" =~ ^(y|Y)$ ]]; then
    curl -s -u admin:admin \
    -X POST "$URL"/etc/packages/com.pearson.aem/demo-sites-content-2.0.970-SNAPSHOT.zip\?cmd\=install
    if test $? -ne 0; then
        echo "Install failed."
    fi
  fi
fi

# BACKSTOP LATEST
backstop latest

# FALCON TEST 

cd "$AEMpath"/aem-falcon-tests/ && mvn clean verify -Plocal_6_4,all_sites -Dcucumber.option="--tags @PMCCP-9405"

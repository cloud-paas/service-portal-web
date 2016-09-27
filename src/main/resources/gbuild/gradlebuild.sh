#!/bin/bash
SRC_HOME=/aifs01/devusr01/applications/service-sdk-fat
echo "cope build.gradle file !!!"
echo $PWD
cp ./build.gradle ${SRC_HOME}
echo "gradle build starting!"
gradle build jar -p ${SRC_HOME}
scp ${SRC_HOME}/build/libs/service-sdk-fat-1.0.jar devusr02@10.1.228.198:/aifs01/devusers/devusr02/iPaaS_DownLoad_Resource/SDK

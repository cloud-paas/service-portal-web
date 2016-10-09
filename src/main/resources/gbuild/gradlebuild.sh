#!/bin/bash
SRC_HOME=/aifs01/devusr01/applications/service-sdk-fat
edit_hm=/aifs01/devusr01/applications/PAASTD1_PORTAL-S1/service-portal-web/WEB-INF/classes/gbuild
echo "cope build.gradle file !!!"
echo $PWD
cp ${edit_hm}/build.gradle ${SRC_HOME}
echo "gradle build starting!"
cd ${SRC_HOME} && gradle build jar && scp ${SRC_HOME}/build/libs/service-sdk-fat-1.0.jar devusr02@10.1.228.198:/aifs01/devusers/devusr02/iPaaS_DownLoad_Resource/SDK

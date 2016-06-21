#!/bin/bash

\cp rf /aifs01/users/tstusr11/applications/TD1_TST-S1/service-portal-web/WEB-INF/classes/gbuild/build.gradle /aifs01/users/tstusr11/applications/service-sdk-fat

echo "gradle build starting!"
cd /aifs01/users/tstusr11/applications/service-sdk-fat && gradle publish

scp /aifs01/users/tstusr11/applications/service-sdk-fat/iPaaS_DownLoad_Resource/com/ai/ipaas-sdk/0.2.1/ipaas-sdk-0.2.1.jar devusr02@10.1.228.198:/aifs01/devusers/devusr02/iPaaS_DownLoad_Resource/SDK

echo "Done!"
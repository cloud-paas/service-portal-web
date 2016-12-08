#!/bin/sh
userStr=""

sed -i "s/default.dubbo.registry.address=.*/default.dubbo.registry.address=${DUBBO_REGISTRY_ADDR}/g" /opt/apache-tomcat-8.0.35/webapps/service-portal-web/WEB-INF/classes/common/dubbo.properties
sed -i "s/default.dubbo.protocol.port=.*/default.dubbo.protocol.port=${DUBBO_PORT}/g" /opt/apache-tomcat-8.0.35/webapps/service-portal-web/WEB-INF/classes/common/dubbo.properties
sed -i "s/zookeeper.address=.*/zookeeper.address=${ZK_ADDR}/g" /opt/apache-tomcat-8.0.35/webapps/service-portal-web/WEB-INF/classes/zookeeper.properties

sed -i "s/8080/${SERVER_PORT}/g" /opt/apache-tomcat-8.0.35/conf/server.xml
sed -i "s/8005/${SHUTDOWN_PORT}/g" /opt/apache-tomcat-8.0.35/conf/server.xml
sed -i "s/8009/${APJ_PORT}/g" /opt/apache-tomcat-8.0.35/conf/server.xml


if [ -n "$LOG_LEVEL" ]; then   
    sed -i "s/<Root level=.*/<Root level=\"${LOG_LEVEL}\">/g" /opt/apache-tomcat-8.0.35/webapps/service-portal-web/WEB-INF/classes/log4j2.xml   
fi

if [ -n "$AccessUsers" ]; then
  arr=(${AccessUsers//,/ })    
    
  for i in ${arr[@]}    
    do    
      $userStr=${userStr}"{\"userEmail\":\"$i\"},"   
    done 
  sed -i "s/userAccessList = .*/userAccessList = \"{\\"accessUsers\\":[${userStr}]}\"/g" /opt/apache-tomcat-8.0.35/webapps/service-portal-web/WEB-INF/classes/common/userAccess.properties
fi

nohup /opt/apache-tomcat-8.0.35/bin/catalina.sh run >> /service-portal-web.log
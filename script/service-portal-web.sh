#!/bin/sh

sed -i "s/default.dubbo.registry.address=.*/default.dubbo.registry.address=${DUBBO_REGISTRY_ADDR}/g" /opt/apache-tomcat-8.0.35/webapps/service-portal-web/WEB-INF/classes/common/dubbo.properties
sed -i "s/default.dubbo.protocol.port=.*/default.dubbo.protocol.port=${DUBBO_PORT}/g" /opt/apache-tomcat-8.0.35/webapps/service-portal-web/WEB-INF/classes/common/dubbo.properties
sed -i "s/zookeeper.address=.*/zookeeper.address=${ZK_ADDR}/g" /opt/apache-tomcat-8.0.35/webapps/service-portal-web/WEB-INF/classes/zookeeper.properties

sed -i "s/8080/${TOMCAT_PORT}/g" /opt/apache-tomcat-8.0.35/conf/server.xml

nohup /opt/apache-tomcat-8.0.35/bin/catalina.sh run >> /service-portal-web.log
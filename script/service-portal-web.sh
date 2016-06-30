#!/bin/sh

sed -i "s/default.dubbo.registry.address=.*/default.dubbo.registry.address=${DUBBO_REGISTRY_ADDR}/g" ${DUBBO_FILE}
sed -i "s/default.dubbo.protocol.port=.*/default.dubbo.protocol.port=${DUBBO_PORT}/g" ${DUBBO_FILE}
sed -i "s/zookeeper.address=.*/zookeeper.address=${ZK_ADDR}/g" ${ZOOKEEPER_FILE}

sed -i "s/8080/${TOMCAT_PORT}/g" /opt/apache-tomcat-8.0.35/conf/server.xml

nohup /opt/apache-tomcat-8.0.35/bin/catalina.sh run >> /service-portal-web.log
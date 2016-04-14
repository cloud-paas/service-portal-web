package com.ai.paas.ipaas.config.param;

import java.io.Serializable;

/**
 * Created by astraea on 2015/4/2.
 */
@SuppressWarnings("serial")
public class ServiceParam implements Serializable {
    private String serviceName;
    private String userId;
    private String userName;

    public ServiceParam() {

    }

    public ServiceParam(String serviceName, String userId, String userName) {
        super();
        this.serviceName = serviceName;
        this.userId = userId;
        this.userName = userName;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

}
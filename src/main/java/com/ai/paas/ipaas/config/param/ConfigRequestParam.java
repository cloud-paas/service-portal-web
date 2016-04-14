package com.ai.paas.ipaas.config.param;

import java.io.Serializable;

/**
 * Created by astraea on 2015/4/2.
 */
@SuppressWarnings("serial")
public class ConfigRequestParam implements Serializable {
    private String serviceId;
    private String path;
    private String data;
    private String userId;
    
	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
}
package com.ai.paas.ipaas.maintain.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class UserIdModel implements Serializable {
	//用户ID
	private String userId;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
}

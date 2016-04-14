package com.ai.paas.ipaas.maintain.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class UserModel implements Serializable {
private String userName;
	
	private String userPwd;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
		
}

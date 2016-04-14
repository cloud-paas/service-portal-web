package com.ai.paas.ipaas.user.vo;

import java.io.Serializable;
import java.sql.Timestamp;

public class UserInfoVo implements Serializable {

	/**
	 * @author jonrey
	 */
	private static final long serialVersionUID = -9108197856282461570L;

	public UserInfoVo() {
	}

	private String userId;
	private String pid;

	private String userOrgName;

	private String userEmail;

	private String userPhoneNum;

	private String userState;

	private Timestamp userRegisterTime;

	private Timestamp userActiveTime;

	private Timestamp userCancelTime;

	private String userInsideTag;

	private String userName;
	
	private String partnerType;
	
	private String partnerAccount;
	private String userEmailTmp;
	

	public String getUserEmailTmp() {
		return userEmailTmp;
	}

	public void setUserEmailTmp(String userEmailTmp) {
		this.userEmailTmp = userEmailTmp;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getUserOrgName() {
		return userOrgName;
	}

	public void setUserOrgName(String userOrgName) {
		this.userOrgName = userOrgName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPhoneNum() {
		return userPhoneNum;
	}

	public void setUserPhoneNum(String userPhoneNum) {
		this.userPhoneNum = userPhoneNum;
	}

	public String getUserState() {
		return userState;
	}

	public void setUserState(String userState) {
		this.userState = userState;
	}

	public Timestamp getUserRegisterTime() {
		return userRegisterTime;
	}

	public void setUserRegisterTime(Timestamp userRegisterTime) {
		this.userRegisterTime = userRegisterTime;
	}

	public Timestamp getUserActiveTime() {
		return userActiveTime;
	}

	public void setUserActiveTime(Timestamp userActiveTime) {
		this.userActiveTime = userActiveTime;
	}

	public Timestamp getUserCancelTime() {
		return userCancelTime;
	}

	public void setUserCancelTime(Timestamp userCancelTime) {
		this.userCancelTime = userCancelTime;
	}

	public String getUserInsideTag() {
		return userInsideTag;
	}

	public void setUserInsideTag(String userInsideTag) {
		this.userInsideTag = userInsideTag;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPartnerType() {
		return partnerType;
	}

	public void setPartnerType(String partnerType) {
		this.partnerType = partnerType;
	}

	public String getPartnerAccount() {
		return partnerAccount;
	}

	public void setPartnerAccount(String partnerAccount) {
		this.partnerAccount = partnerAccount;
	}

}

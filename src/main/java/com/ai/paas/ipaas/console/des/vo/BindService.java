package com.ai.paas.ipaas.console.des.vo;

public class BindService {
	private String userId;
	private String serviceId;
	private String dbsServiceId;
	private String mdsServiceId;
	private String mdsServicePassword;
	private String[] boundTables;
	private String[] unboundTables;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
	public String getDbsServiceId() {
		return dbsServiceId;
	}
	public void setDbsServiceId(String dbsServiceId) {
		this.dbsServiceId = dbsServiceId;
	}
	public String getMdsServiceId() {
		return mdsServiceId;
	}
	public void setMdsServiceId(String mdsServiceId) {
		this.mdsServiceId = mdsServiceId;
	}
	public String getMdsServicePassword() {
		return mdsServicePassword;
	}
	public void setMdsServicePassword(String mdsServicePassword) {
		this.mdsServicePassword = mdsServicePassword;
	}
	public String[] getBoundTables() {
		return boundTables;
	}
	public void setBoundTables(String[] boundTables) {
		this.boundTables = boundTables;
	}
	public String[] getUnboundTables() {
		return unboundTables;
	}
	public void setUnboundTables(String[] unboundTables) {
		this.unboundTables = unboundTables;
	}
}

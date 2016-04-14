package com.ai.paas.ipaas.console.des.vo;

public class DesInfoVo {
	
	private String serviceId;
	private String serviceName;
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	private String dbsServiceId;
	private String mdsServiceId;
	private String[] boundTables;
	private String[] unboundTables;
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

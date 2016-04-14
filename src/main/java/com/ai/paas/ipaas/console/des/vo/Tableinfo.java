package com.ai.paas.ipaas.console.des.vo;

public class Tableinfo {
	private String resultCode;
	private String resultDesc;
	private String[] boundTables;
	private String[] unboundTables;
	public String getResultCode() {
		return resultCode;
	}
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	public String getResultDesc() {
		return resultDesc;
	}
	public void setResultDesc(String resultDesc) {
		this.resultDesc = resultDesc;
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

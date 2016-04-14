package com.ai.paas.ipaas.console.des.vo;

import java.util.List;

public class BoundResult {
	private String resultCode;
	private String resultDesc;
	private List<BindService> bindServices;
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
	public List<BindService> getBindServices() {
		return bindServices;
	}
	public void setBindServices(List<BindService> bindServices) {
		this.bindServices = bindServices;
	}
}

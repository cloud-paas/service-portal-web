package com.ai.paas.ipaas.apply.vo;

import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailVo;

public class OrderDetailLocalVo extends OrderDetailVo {
    private static final long serialVersionUID = 8823461567217438599L;

    private String orderAppDateStr;
    private String prodNameStr;
    private String oaCheckUrl;//oa审批查看地址
    
    

    public String getOaCheckUrl() {
		return oaCheckUrl;
	}

	public void setOaCheckUrl(String oaCheckUrl) {
		this.oaCheckUrl = oaCheckUrl;
	}

	public String getOrderAppDateStr() {
        return orderAppDateStr;
    }

    public void setOrderAppDateStr(String orderAppDateStr) {
        this.orderAppDateStr = orderAppDateStr;
    }

	public String getProdNameStr() {
		return prodNameStr;
	}

	public void setProdNameStr(String prodNameStr) {
		this.prodNameStr = prodNameStr;
	}
}
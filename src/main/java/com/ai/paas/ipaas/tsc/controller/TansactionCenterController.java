package com.ai.paas.ipaas.tsc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.alibaba.dubbo.config.annotation.Reference;

@Controller
@RequestMapping(value = "/tsc")
public class TansactionCenterController {
	@Reference
	private IOrder iOrder;
	
	@Reference
	private ISysParamDubbo iSysParam;
	
	@RequestMapping(value="/introduce")
	public String toIndex(HttpServletRequest request,HttpServletResponse response){
		return "tansactionCenter/introduce";
	}

}

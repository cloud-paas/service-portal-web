package com.ai.paas.ipaas.softwareInstall.controller;


import java.io.IOException;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.cache.CacheUtils;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.user.utils.gson.GsonUtil;

@Controller
@RequestMapping(value = "/softwareInstall")
public class SoftwareInstallController {

	private static final Logger logger = LogManager
			.getLogger(SoftwareInstallController.class);
	
	@RequestMapping(value="/softInit")
	public String openInit(HttpServletRequest request,HttpServletResponse response)
	{
		String orderDetailId=request.getParameter("DetailId");
		String orderWoId=request.getParameter("WoId");
		String operateId=request.getParameter("operate_id");
		String kkpage=request.getParameter("kkpage");
		request.setAttribute("orderDetailId", orderDetailId);
		request.setAttribute("orderWoId",orderWoId);
		request.setAttribute("operateId",operateId);
		request.setAttribute("kkpage",kkpage);//暂存跳转页面的页数
		return "/softConfig/softInit";
		
	}
	
	/**
	 * 安装软件
	 * 
	 * @return
	 */
	
	@RequestMapping(value="/softInstallSubmit",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String softInstallSubmit(HttpServletRequest request,HttpServletResponse response){
		
		String orderDetailId = request.getParameter("orderDetailId");		
		String softsConfig = request.getParameter("softsConfig");		
		String orderWoId = request.getParameter("orderWoId");		
		String operateID = request.getParameter("operateId");
		
		Map map = new HashMap();
		JSONObject jsondata = new JSONObject();
		jsondata.put("orderDetailId", orderDetailId);
		map.put("orderDetailId", orderDetailId);
		map.put("softsConfig", softsConfig);
		map.put("orderWoId", orderWoId);
		map.put("operateID", operateID);
		
		String param = GsonUtil.toJSon(map);
		
		String result = null;
		
		String service =CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");
		
		//String service = "http://192.168.1.113:20881/ipaas";
		String url = "/softwareInstall/softwareInstallSubmit";
		System.out.println("to MAIN rest:" + service + url);
		try {
			result = HttpClientUtil.sendPostRequest(service + url, param);
			System.out.println("MAIN return :" + result);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}		

		return result;
		
	}

	
}

package com.ai.paas.ipaas.virtual.controller;

import java.io.IOException;
import java.net.URISyntaxException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.cache.CacheUtils;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.vo.UserInfoVo;


/**
 * 虚拟机申请订单跟踪查询
 * @author renfeng
 *
 */
@Controller
@RequestMapping(value="/vmQuery")
public class VmQueryController {
	private static final Logger logger = LogManager.getLogger(VmQueryController.class.getName());
	
	@RequestMapping(value="/vmQuery")
	public String vmSearch(HttpServletRequest request,HttpServletResponse response){
		return "/virtualMachine/VmFollowQuery";
	}
	/**
	 * 跟踪订单查询
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/vmOrderDetailQuery",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmOrderDetailQuery(HttpServletRequest request,HttpServletResponse response){
		String jsondata = request.getParameter("jsondata");
		String service =CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");//http://10.1.228.198:10889/ipaas
//		String service = "http://127.0.0.1:20881/ipaas";
		String url = "/vmQuery/queryOrderDetail";
		String result = null;
		try {
			result = HttpClientUtil.sendPostRequest(service + url, jsondata);
			System.out.println("========跟踪订单查询结果========:" + result);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}		
		if(result!=null&& !"".equals(result)){
			return result;
		}else{
			return "";
		}
	}
	/**
	 * 跟踪工单查询
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/vmOrderWoQuery",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmOrderWoQuery(HttpServletRequest request,HttpServletResponse response){
		String jsondata = request.getParameter("jsondata");
		JSONObject json = new JSONObject(jsondata);
		String service =CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");//http://10.1.228.198:10889/ipaas
//		String service = "http://127.0.0.1:20881/ipaas";
		String url = "/vmQuery/queryOrderWo";
		String result =null;
		try {
			result = HttpClientUtil.sendPostRequest(service + url, json.getString("orderDetailId"));
			System.out.println("=======跟踪工单查询结果=========:" + result);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}		
		if(result!=null&& !"".equals(result)){
			return result;
		}else{
			return "";
		}
		
	}
	
	
	
}

package com.ai.paas.ipaas.virtual.controller;
import java.io.IOException;
import java.net.URISyntaxException;





import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

































import net.sf.json.util.JSONUtils;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.cache.CacheUtils;
import com.ai.paas.ipaas.rcs.utils.JsonUtils;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.JSonUtil;
import com.ai.paas.ipaas.utils.HttpRequestUtil;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
 

@Controller
@RequestMapping(value="/VirtualIntegration")
public class VirtualIntegrationController{
	
	
	@RequestMapping(value="/vmSearch")
	public String vmSearch(HttpServletRequest request,HttpServletResponse response){
		String email=request.getParameter("userEmail");
		/*String email="dingyi5@asiainfo.com";*/
		if(email==null||email==""){
			UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
			email=userInfoVo.getUserEmailTmp();
		}
		
		String[] splitarray=email.split("@");
		String operateId=splitarray[0];
		request.setAttribute("operateId", operateId);
		return "/virtualMachine/VirtualIntegration";
	}
	/**
	 * Iaas资源申请订单详情页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/vmDetail")
	public String vmDetail(HttpServletRequest request,HttpServletResponse response){
		String orderDetailId=request.getParameter("orderDetailId");
		request.setAttribute("orderDetailId", orderDetailId);
		return "/virtualMachine/vmOrderDetail";
	}
	
	@RequestMapping(value="/vmSelect",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmSelect(HttpServletRequest request,HttpServletResponse response) throws IOException, URISyntaxException, PaasException{
		String jsondata = request.getParameter("jsondata");
		String orderDetailResult = getOrderDetail(jsondata);
		return orderDetailResult;
	}
	/**
	 * 邮件模版信息
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws URISyntaxException
	 * @throws PaasException
	 */
	@RequestMapping(value="/orderDetailQuery",produces = "application/json;charset=utf-8")
	public @ResponseBody String orderDetailQuery(HttpServletRequest request,HttpServletResponse response) throws IOException, URISyntaxException, PaasException{
		String orderDetailId=request.getParameter("orderDetailId");
		JSONObject paramsJson = new JSONObject();
		paramsJson.put("orderDetailId", orderDetailId);
		String orderDetailResult = getOrderDetail(paramsJson.toString());
		
		JSONObject resultJson = new JSONObject(orderDetailResult);
		 JSONArray jsonArray = resultJson.getJSONArray("list");
		 String orderDetailStr = jsonArray.get(0).toString();
		 JSONObject orderDetailJson = new JSONObject(orderDetailStr);
		 
		 String prodParam = orderDetailJson.getString("prodParam");
		 JSONObject prodParamJson = new JSONObject(prodParam);
		 
		 Map<String,String> map = new HashMap<String,String>();
		 map.put("virtualType", prodParamJson.getString("virtualType"));//虚拟机类型
		 map.put("cpu", prodParamJson.getString("cpu"));//CPU
		 if(orderDetailJson.getString("belongCloud")!=null && "2".equals(orderDetailJson.getString("belongCloud"))){
			 map.put("netType", prodParamJson.getString("netType"));//链路类型
			 map.put("netBandW", prodParamJson.getString("netBandW"));//公网宽带
			 map.put("netNum", prodParamJson.getString("netNum"));//公网数量
		 }else{
			 map.put("netType", "无");//链路类型
			 map.put("netBandW", "无");//公网宽带
			 map.put("netNum", "无");//公网数量
		 }
		 map.put("virtualRam", prodParamJson.getString("virtualRam"));//内存
		 map.put("virtualHard", prodParamJson.getString("virtualHard"));//数据盘容量
		 map.put("SysTem", prodParamJson.getString("SysTem")+"  "+prodParamJson.getString("SysTemChild"));//操作系统
		 
		 map.put("applicant", orderDetailJson.getString("applicant"));//报告人
		 map.put("applicantDept", orderDetailJson.getString("applicantDept"));//申请部门
		 map.put("applicantTel", orderDetailJson.getString("applicantTel"));//联系方式
		 map.put("applicantEmail", orderDetailJson.getString("applicantEmail"));//邮箱地址
		 map.put("applicantReason", orderDetailJson.getString("applicantReason"));//申请原因
		 map.put("costCenterName", orderDetailJson.getString("costCenterName"));//项目代码/名称
		 map.put("userMaxNumbers", String.valueOf(orderDetailJson.getInt("userMaxNumbers")));//用户数
		 map.put("concurrentNumbers", String.valueOf(orderDetailJson.getInt("concurrentNumbers")));//并发访问量
		 map.put("vmNumber", String.valueOf(orderDetailJson.getInt("vmNumber")));//虚拟机数量
		 if("1".equals(orderDetailJson.getString("applyType"))){
			 map.put("applyType", "新建");//资源申请方式
		 }else{
			 map.put("applyType", "变更");//资源申请方式
		 }
		 if("1".equals(orderDetailJson.getString("useType"))){
			 map.put("useType", "开发");//用途说明
		 }else if("2".equals(orderDetailJson.getString("useType"))){
			 map.put("useType", "测试");//用途说明
		 }else if("3".equals(orderDetailJson.getString("useType"))){
			 map.put("useType", "生产");//用途说明
		 }else if("4".equals(orderDetailJson.getString("useType"))){
			 map.put("useType", "其他");//用途说明
		 }
		 map.put("applyDesc", orderDetailJson.getString("applyDesc"));//业务描述
		 map.put("orderAppDate", orderDetailJson.getString("orderAppDate").substring(0, 10));//申请时间
		 map.put("expirationDate", orderDetailJson.getString("expirationDate").substring(0, 10));//到期时间
		
		 JSONObject orderDetailJsonResult = new JSONObject(map);
		 byte[] fullByte = new String(orderDetailJsonResult.toString().getBytes("utf-8"), "utf-8").getBytes("GBK");  
		 String fullStr = new String(fullByte, "GBK");
		
		 return fullStr;
	}
	/**
	 * 查询订单列表
	 * @param params
	 * @return
	 */
	public String getOrderDetail(String params){
		String result=null;
		String service =CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");//http://10.1.228.198:10889/ipaas
		//String service = "http://127.0.0.1:20881/ipaas";
		String url = "/order/queryOrdersInfo";
		try {
			result = HttpClientUtil.sendPostRequest(service + url, params);
			System.out.println("========订单详情========:" + result);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}		
		
		if(result!=null&&!"".equals(result)){
			return result;
		}else{
			return "{\"msg\":\"未查询到订单！\"}";
		}
	}
	
	
	
	/**
	 * Iaas资源申请订单详情查询
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws URISyntaxException
	 * @throws PaasException
	 */
	@RequestMapping(value="/vmDetailSelect",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmDetailSelect(HttpServletRequest request,HttpServletResponse response) throws IOException, URISyntaxException, PaasException
	{
		String jsondata = request.getParameter("jsondata");
		String result=null;
		String service =CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");//http://10.1.228.198:10889/ipaas
//		String service = "http://127.0.0.1:20881/ipaas";
		String url = "/order/queryOrdersInfo";
		try {
			result = HttpClientUtil.sendPostRequest(service + url, jsondata);
			System.out.println("\nqueryOrdersInfo|||||||:" + result);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}		
		
		if(result!=null&&!"".equals(result)){
			return result;
		}else{
			return "{\"msg\":\"未查询到订单！\"}";
		}
	}
	
	
	
	
	
	
	public static void main(String[] args) throws Exception {
		
		
		JSONObject obj = new JSONObject();
		obj.put("orderDetailId", "2190");
		VirtualIntegrationController VirtualIntegrationController = new VirtualIntegrationController();
		String orderDetail = VirtualIntegrationController.getOrderDetail(obj.toString());

 
		String service = "http://localhost:8080/iPaas-Portal/VirtualIntegration/orderDetailQuery";  
					 JSONObject resultJson = new JSONObject(orderDetail);
					 JSONArray jsonArray = resultJson.getJSONArray("list");
					 String orderDetailStr = jsonArray.get(0).toString();
					 JSONObject orderDetailJson = new JSONObject(orderDetailStr);
					 
					 String prodParam = orderDetailJson.getString("prodParam");
					 JSONObject prodParamJson = new JSONObject(prodParam);
					 
					 Map<String,String> map = new HashMap<String,String>();
					 map.put("virtualType", prodParamJson.getString("virtualType"));//虚拟机类型
					 map.put("cpu", prodParamJson.getString("cpu"));//CPU
					 if(orderDetailJson.getString("belongCloud")!=null && "2".equals(orderDetailJson.getString("belongCloud"))){
						 map.put("netType", prodParamJson.getString("netType"));//链路类型
						 map.put("netBandW", prodParamJson.getString("netBandW"));//公网宽带
						 map.put("netNum", prodParamJson.getString("netNum"));//公网数量
					 }else{
						 map.put("netType", "无");//链路类型
						 map.put("netBandW", "无");//公网宽带
						 map.put("netNum", "无");//公网数量
					 }
					 map.put("virtualRam", prodParamJson.getString("virtualRam"));//内存
					 map.put("virtualHard", prodParamJson.getString("virtualHard"));//数据盘容量
					 map.put("SysTem", prodParamJson.getString("SysTem")+"  "+prodParamJson.getString("SysTemChild"));//操作系统
					 
					 map.put("applicant", orderDetailJson.getString("applicant"));//报告人
					 map.put("applicantDept", orderDetailJson.getString("applicantDept"));//申请部门
					 map.put("applicantTel", orderDetailJson.getString("applicantTel"));//联系方式
					 map.put("applicantEmail", orderDetailJson.getString("applicantEmail"));//邮箱地址
					 map.put("applicantReason", orderDetailJson.getString("applicantReason"));//申请原因
					 map.put("costCenterName", orderDetailJson.getString("costCenterName"));//项目代码/名称
					 map.put("userMaxNumbers", String.valueOf(orderDetailJson.getInt("userMaxNumbers")));//用户数
					 map.put("concurrentNumbers", String.valueOf(orderDetailJson.getInt("concurrentNumbers")));//并发访问量
					 map.put("vmNumber", String.valueOf(orderDetailJson.getInt("vmNumber")));//虚拟机数量
					 if("1".equals(orderDetailJson.getString("applyType"))){
						 map.put("applyType", "新建");//资源申请方式
					 }else{
						 map.put("applyType", "变更");//资源申请方式
					 }
					 if("1".equals(orderDetailJson.getString("useType"))){
						 map.put("useType", "开发");//用途说明
					 }else if("2".equals(orderDetailJson.getString("useType"))){
						 map.put("useType", "测试");//用途说明
					 }else if("3".equals(orderDetailJson.getString("useType"))){
						 map.put("useType", "生产");//用途说明
					 }else if("4".equals(orderDetailJson.getString("useType"))){
						 map.put("useType", "其他");//用途说明
					 }
					 map.put("applyDesc", orderDetailJson.getString("applyDesc"));//业务描述
					 map.put("orderAppDate", orderDetailJson.getString("orderAppDate"));//申请时间
					 map.put("expirationDate", orderDetailJson.getString("expirationDate"));//到期时间
					
					 JSONObject orderDetailJsonResult = new JSONObject(map);
					 
					System.out.println("==============orderDetailJsonResult============"+orderDetailJsonResult.toString());		
		
	}

		

}
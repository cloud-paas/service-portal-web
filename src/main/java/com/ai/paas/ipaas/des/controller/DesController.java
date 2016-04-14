package com.ai.paas.ipaas.des.controller;
import java.io.IOException;
import java.net.URISyntaxException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.cache.CacheUtils;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailRequest;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailResponse;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.JSonUtil;
import com.alibaba.dubbo.config.annotation.Reference;
 
 
 

 

 
@Controller
@RequestMapping(value="/des")
public class DesController {
	@Reference
	private ISysParamDubbo iSysParam;
		@RequestMapping(value="/initapply",method={RequestMethod.GET})
		public String initApply(HttpServletRequest request,HttpServletResponse response){
			request.getSession().removeAttribute("list_index");
	        request.getSession().setAttribute("list_index", "list_14");
			return "/des/introduce";
			
		}
		
		@RequestMapping(value="/DesApplyPage",method={RequestMethod.GET})
		public String desApplyPage(HttpServletRequest request,HttpServletResponse response)
		{
			return "/des/DesApplyPage";
			
		}
		
		@RequestMapping(value="/desApply",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
		public @ResponseBody String desApply(HttpServletRequest request,HttpServletResponse response) throws IOException, URISyntaxException, PaasException
		{
			
		
			OrderDetailRequest orderDetailRequest=new OrderDetailRequest();
			orderDetailRequest.setProdId(Constants.serviceType.DES_CENTER);
			orderDetailRequest.setProdType(Constants.ProductType.IPAAS_JiSuan); //PROD_IAAS // 1存储  2计算   3 数据库服务  //  1计算   2 数据库服务  3存储  2015.11.6
			orderDetailRequest.setProdByname(Constants.serviceName.DES);
			orderDetailRequest.setOperateType(Constants.OperateType.APPLY);
			UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
			orderDetailRequest.setUserId(userInfoVo.getUserId());
			JSONObject prodparms=new JSONObject();
			prodparms.put("serviceName", request.getParameter("serviceName"));
			
			orderDetailRequest.setProdParam(prodparms.toString());
			orderDetailRequest.setUserServIpaasPwd(request.getParameter("serivcePwd"));
			
			String data=JSonUtil.toJSon(orderDetailRequest);
			
			String address = CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");
			String result=HttpClientUtil.sendPostRequest(address+"/user/order/applyOrders", data);
						
			OrderDetailResponse orderDetailResponse=JSonUtil.fromJSon(result, OrderDetailResponse.class);
			JSONObject obj=new JSONObject();
			obj.put("code", orderDetailResponse.getResponseHeader().getResultCode());
			obj.put("message", orderDetailResponse.getResponseHeader().getResultMessage());
			
			return obj.toString();
			
		}
}

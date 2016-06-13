package com.ai.paas.ipaas.cache.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.email.EmailServiceImpl;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.IProdProductDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.EmailDetail;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailRequest;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailResponse;
import com.ai.paas.ipaas.user.dubbo.vo.SysParamVo;
import com.ai.paas.ipaas.user.dubbo.vo.SysParmRequest;
import com.ai.paas.ipaas.user.utils.gson.GsonUtil;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.JsonObject;

@Controller
@RequestMapping(value = "/mcs")
public class CacheController {
	private static final Logger logger = LogManager.getLogger(CacheController.class.getName());
	
	@Reference
	private IOrder iOrder;
	
	@Reference
	private ISysParamDubbo iSysParam;
	
	@Reference
	private IProdProductDubboSv iProdProductDubboSv;
	
	@Autowired
	private EmailServiceImpl emailSrv;
	
	/**
	 * 跳转到cache首页
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/introduce")
	public String toIndex(HttpServletRequest request,HttpServletResponse response){
        request.getSession().removeAttribute("list_index");
        request.getSession().setAttribute("list_index", "list_5");
		return "cache/introduce";
	}
	
	/**
	 * 跳转到开通cache页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/toOpenCache")
	public String toOpenCache(HttpServletRequest request,HttpServletResponse response) throws Exception {
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode(Constants.serviceName.MCS);
		req.setParamCode(Constants.paramCode.OPTIONS);
		List<SysParamVo> sizeList = iSysParam.getSysParams(req);
		request.setAttribute("sizeList", sizeList);
		return "cache/openCache";	
	}
	
	/**
	 * 开通缓存
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/openCache",produces = {"application/json;charset=UTF-8"})
	public  @ResponseBody String openCache(HttpServletRequest request, HttpServletResponse response){
		String haMode=request.getParameter("my_haMode");
		String serviceName=request.getParameter("my_name");
		String userServIpaasPwd=request.getParameter("my_password");
		String capacity=request.getParameter("my_capacity");
		String userId=UserUtil.getUserSession(request.getSession()).getUserId();
		//String userId="111";
		OrderDetailRequest orderDetailRequest=new OrderDetailRequest();
		orderDetailRequest.setUserId(userId);								//用户ID
		orderDetailRequest.setOperateType(Constants.OperateType.APPLY);		//操作类型
		orderDetailRequest.setProdId("2");									//产品ID
		orderDetailRequest.setProdType(Constants.ProductType.IPAAS_CunChu);	 //PROD_IPAAS	//产品类型
		orderDetailRequest.setProdByname(Constants.serviceName.MCS);		//产品类型简写
		orderDetailRequest.setUserServIpaasPwd(userServIpaasPwd); 			//服务密码
				
		JsonObject prodParamJson = new JsonObject();
		prodParamJson.addProperty("capacity", capacity);
		prodParamJson.addProperty("haMode", haMode);
		prodParamJson.addProperty("serviceName", serviceName);
		logger.info("产品参数："+prodParamJson.toString());
		orderDetailRequest.setProdParam(prodParamJson.toString());
		
		JsonObject resultJson = new JsonObject();
		
		logger.info("调用saveOrderDetail----------");
		OrderDetailResponse orderDetailResponse = new OrderDetailResponse();
		try {
			orderDetailResponse = iOrder.saveOrderDetail(orderDetailRequest);
			
			logger.info("根据orderDetailResponse结果，发送MCS服务开通的待审核提醒邮件----------");
			if (orderDetailResponse.isNeedSend() && orderDetailResponse.getEmail() != null) {
				for(EmailDetail email: orderDetailResponse.getEmail()) {
					emailSrv.sendEmail(email);
				}
			}
		} catch (Exception e) {
			logger.error(e.getCause().getMessage() + e.getMessage() + "---------");
			resultJson.addProperty("resultCode","999999");
			resultJson.addProperty("resultMessage", "saveOrderDetail error");
		}
		
		logger.info("saveOrderDetail返回结果："+orderDetailResponse.getResponseHeader().getResultCode()+":"+orderDetailResponse.getResponseHeader().getResultMessage());
		resultJson.addProperty("resultCode",orderDetailResponse.getResponseHeader().getResultCode());
		resultJson.addProperty("resultMessage", orderDetailResponse.getResponseHeader().getResultMessage());
		
		return resultJson.toString();
	}
	
	@RequestMapping(value="/applyCompleted")
	public String applyCompleted( ModelMap model,HttpServletRequest request,HttpServletResponse response) {
		String prod = request.getParameter("prod");
		String url = request.getParameter("url");
		String flag = request.getParameter("flag"); //Update

		String res = iProdProductDubboSv.selectProductByProdEnSimp(prod);
		JSONObject ObjJson = new JSONObject(res);
		String prodName =ObjJson.get("prodName").toString();
		
		Date d = new Date () ;   
		SimpleDateFormat df = new SimpleDateFormat( "yyyy年 MM月 dd号" );   
		String   dateStr = df.format(new Date( d.getTime() + 6 * 24 * 60 * 60 * 1000));
		model.addAttribute("dateStr", dateStr);
		model.addAttribute("prod", prod);
		model.addAttribute("prodName", prodName);
		model.addAttribute("url", url);
		model.addAttribute("flag", flag);  //值为Update
		//model.addAttribute("prodType", prodType);
		return "cache/applyCompleted";
	}
	
	/**
	 * 扩容缓存
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/expenseCache",produces = {"application/json;charset=UTF-8"})
	public  @ResponseBody String expenseCache(HttpServletRequest request,
			HttpServletResponse response){
		String userServIpaasId=request.getParameter("userServIpaasId");
		String capacity=request.getParameter("capacity");
		String prodParam=request.getParameter("prodParam");
		String userServId=request.getParameter("userServId");		
		String userId=UserUtil.getUserSession(request.getSession()).getUserId();
		
		OrderDetailRequest orderDetailRequest = new OrderDetailRequest();
		orderDetailRequest.setUserId(userId);								//用户ID
		orderDetailRequest.setOperateType(Constants.OperateType.UPDATE);		//操作类型
		orderDetailRequest.setProdId("2");									//产品ID
		orderDetailRequest.setProdType(Constants.ProductType.IPAAS_CunChu);	 //PROD_IPAAS	//产品类型
		orderDetailRequest.setProdByname(Constants.serviceName.MCS);		//产品类型简写
		orderDetailRequest.setUserServIpaasPwd(""); 			//服务密码
				
		@SuppressWarnings("rawtypes")
		Map map = GsonUtil.fromJSon(prodParam,Map.class);
		map.put("serviceId", userServIpaasId);
		map.put("userServId", userServId);		
		map.put("capacity", capacity);
		logger.info("产品参数："+GsonUtil.toJSon(map));
		orderDetailRequest.setProdParam(GsonUtil.toJSon(map));
		
		JsonObject resultJson = new JsonObject();
		
		logger.info("调用saveOrderDetail----------");
		OrderDetailResponse orderDetailResponse = new OrderDetailResponse();
		try {
			orderDetailResponse = iOrder.saveOrderDetail(orderDetailRequest);

			logger.info("根据orderDetailResponse结果，发送MCS扩容的待审核提醒邮件----------");
			if (orderDetailResponse.isNeedSend() && orderDetailResponse.getEmail() != null) {
				for (EmailDetail email : orderDetailResponse.getEmail()) {
					emailSrv.sendEmail(email);
				}
			}
		} catch (Exception e) {
			logger.info(e.getCause().getMessage() + e.getMessage() + "---------");
			resultJson.addProperty("resultCode","999999");
			resultJson.addProperty("resultMessage", "expenseCache() error.");
		}
		
		logger.info("saveOrderDetail返回结果："+orderDetailResponse.getResponseHeader().getResultCode()+":"+orderDetailResponse.getResponseHeader().getResultMessage());
		resultJson.addProperty("resultCode",orderDetailResponse.getResponseHeader().getResultCode());
		resultJson.addProperty("resultMessage", orderDetailResponse.getResponseHeader().getResultMessage());
		
		return resultJson.toString();
	}
}

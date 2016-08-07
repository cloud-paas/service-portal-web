package com.ai.paas.ipaas.rds.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.email.EmailServiceImpl;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.EmailDetail;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailRequest;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailResponse;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;

@Controller
@RequestMapping(value = "/rds")
public class RdsController {
	private static final Logger logger = LogManager
			.getLogger(RdsController.class.getName());

	@Reference
	private IOrder iOrder;
	@Reference
	private ISysParamDubbo iSysParam;
	@Autowired
	private EmailServiceImpl emailSrv;

	@RequestMapping(value = "/introduce")
	public String toIndex(HttpServletRequest request,
			HttpServletResponse response) {
		request.getSession().removeAttribute("list_index");
		request.getSession().setAttribute("list_index", "list_2");
		return "/rds/introduce";
	}

	/**
	 * 准备开通云数据库服务RDS
	 */
	@RequestMapping(value = "/toOpenRds")
	public String toRegisterService(HttpServletRequest request,
			HttpServletResponse response) {
		return "/rds/openRds";
	}

	/**
	 * 开通云数据库服务RDS
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/openRds")
	public Map<String, Object> applyDBSService(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		OrderDetailRequest orderDetailRequest = new OrderDetailRequest();
		orderDetailRequest.setOperateType(Constants.OperateType.APPLY);// 操作类型
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		orderDetailRequest.setUserId(userVo.getUserId()); // 用户Id
		/** PROD_TAB 产品类型: 1存储,2计算,3数据库服务 **/
		orderDetailRequest.setProdType(Constants.ProductType.IPAAS_ShuJK); 
		String prodId = Constants.serviceType.RDS_CENTER + "";
		orderDetailRequest.setProdId(prodId); // 产品id
		orderDetailRequest.setProdByname(Constants.serviceName.RDS); // 别名
		
		Gson prodParam = new Gson();
		Map<String, Object> serviceMap = new HashMap<String, Object>();
		
		serviceMap.put("depId", request.getParameter("depId"));
		serviceMap.put("incName", request.getParameter("incName"));
		serviceMap.put("incType", request.getParameter("incType"));
		serviceMap.put("incTag", request.getParameter("incTag"));
		serviceMap.put("incLocation", request.getParameter("incLocation"));
		serviceMap.put("incDescribe", request.getParameter("incDescribe"));
		serviceMap.put("dbStoreage", request.getParameter("dbStoreage"));
		serviceMap.put("maxConnectNum", request.getParameter("maxConnectNum"));
		
		orderDetailRequest.setProdParam(prodParam.toJson(serviceMap)); // 配置中心参数为空
		orderDetailRequest.setUserServIpaasPwd(request.getParameter("servicePassword"));// 服务密码

		logger.info("调用saveOrderDetail----------");
		OrderDetailResponse orderDetailResponse = new OrderDetailResponse();
		try {
			orderDetailResponse = iOrder.saveOrderDetail(orderDetailRequest);
			logger.info("========= 根据orderDetailResponse结果，发送服务开通的待审核提醒邮件=========");
			if (orderDetailResponse.isNeedSend()
					&& orderDetailResponse.getEmail() != null) {
				for (EmailDetail email : orderDetailResponse.getEmail()) {
					emailSrv.sendEmail(email);
				}
			}
			resultMap.put("code", orderDetailResponse.getResponseHeader().getResultCode());
			resultMap.put("data", prodId);
			resultMap.put("message", orderDetailResponse.getResponseHeader().getResultMessage());
		} catch (Exception e) {
			logger.info(e.getCause().getMessage() + e.getMessage());
			resultMap.put("code", "9999");
			resultMap.put("message", "系统异常，请联系管理员");
		}

		return resultMap;
	}

}

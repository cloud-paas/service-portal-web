package com.ai.paas.ipaas.database.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailRequest;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailResponse;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;

@Controller
@RequestMapping(value = "/dbs")
public class DatabaseController {
	@Reference
	private IOrder iOrder;
	@Reference
	private ISysParamDubbo iSysParam;
	
	private static final Logger logger = LogManager
			.getLogger(DatabaseController.class.getName());
	
	
	@RequestMapping(value="/introduce")
	public String toIndex(HttpServletRequest request,HttpServletResponse response){
        request.getSession().removeAttribute("list_index");
        request.getSession().setAttribute("list_index", "list_2");
		return "/database/introduce";
	}
	
	
	/**
	 * 准备开通分布式数据库服务
	 */
	@RequestMapping(value = "/toOpenDbs")
	public String toRegisterService(HttpServletRequest request,
			HttpServletResponse response) {
		return "/database/openDbs";
	}

	/**
	 * 开通分布式数据库服务
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/openDbs")
	public Map<String, Object> applyDBSService(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		OrderDetailRequest orderDetailRequest = new OrderDetailRequest();
		orderDetailRequest.setOperateType(Constants.OperateType.APPLY);// 操作类型
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		orderDetailRequest.setUserId(userVo.getUserId()); // 用户Id
		orderDetailRequest.setProdType(Constants.ProductType.IPAAS_ShuJK); //PROD_TAB // 产品类型   // 1存储  2计算   3 数据库服务
		String prodId = Constants.serviceType.DBS_CENTER+"";
		orderDetailRequest.setProdId(prodId); // 产品id
		orderDetailRequest.setProdByname(Constants.serviceName.DBS); // 别名
		
		String masterNum = request.getParameter("masterNum"); //主库数量
		String needDistributeTrans = request.getParameter("needDistributeTrans");  //开启分布式事务
		String isMysqlProxy = request.getParameter("isMysqlProxy");  //是否读写分离
		String isAutoSwitch = request.getParameter("isAutoSwitch");  //>是否主从自动切换
		String my_name = request.getParameter("my_name"); //主库数量
		Gson prodParam = new Gson();
		Map<String, Object> serviceMap = new HashMap<String, Object>();
		serviceMap.put("serviceName", my_name);
		serviceMap.put("masterNum", masterNum);
		serviceMap.put("isNeedDistributeTrans", needDistributeTrans);
		serviceMap.put("isMysqlProxy", isMysqlProxy);
		serviceMap.put("isAutoSwitch", isAutoSwitch);
		orderDetailRequest.setProdParam(prodParam.toJson(serviceMap)); // 配置中心参数为空
		orderDetailRequest.setUserServIpaasPwd(request.getParameter("servicePassword"));// 服务密码
		
		logger.info("调用saveOrderDetail----------");
		OrderDetailResponse orderDetailResponse = new OrderDetailResponse();
		try {
			orderDetailResponse = iOrder.saveOrderDetail(orderDetailRequest);
			logger.info("saveOrderDetail返回结果："
					+ orderDetailResponse.getResponseHeader().getResultCode() + ":"
					+ orderDetailResponse.getResponseHeader().getResultMessage());
			resultMap.put("code", orderDetailResponse.getResponseHeader()
					.getResultCode());
			resultMap.put("data", prodId);
			resultMap.put("message", orderDetailResponse.getResponseHeader()
					.getResultMessage());
		} catch (Exception e) {
			logger.info(e.getCause().getMessage() + e.getMessage()
					+ "---------");
			resultMap.put("code", "9999");
			resultMap.put("message", "系统异常，请联系管理员");
		}
		
		return resultMap;
	}
	
}

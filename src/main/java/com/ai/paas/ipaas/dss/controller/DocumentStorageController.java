package com.ai.paas.ipaas.dss.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.database.controller.DatabaseController;
import com.ai.paas.ipaas.email.EmailServiceImpl;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.EmailDetail;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailRequest;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailResponse;
import com.ai.paas.ipaas.user.dubbo.vo.SysParamVo;
import com.ai.paas.ipaas.user.dubbo.vo.SysParmRequest;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.StringUtil;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;

@Controller
@RequestMapping(value = "/dss")
public class DocumentStorageController {
	private static final Logger logger = LogManager.getLogger(DatabaseController.class.getName());
	
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
		request.getSession().setAttribute("list_index", "list_8");
		return "/document/introduce";
	}

	/**
	 * 准备开通分布式数据库服务
	 */
	@RequestMapping(value = "/toOpenDss")
	public String toRegisterService(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode(Constants.serviceName.DSS);
		req.setParamCode("capacity");
		List<SysParamVo> capacityList = iSysParam.getSysParams(req);
		req.setParamCode("singleFileSize");
		List<SysParamVo> fileSizeList = iSysParam.getSysParams(req);
		model.addAttribute("capacityList", capacityList);
		model.addAttribute("fileSizeList", fileSizeList);

		return "/document/openDss";
	}

	/**
	 * 开通分布式数据库服务
	 */
	@ResponseBody
	@RequestMapping(value = "/openDss", method = RequestMethod.POST)
	public Map<String, Object> applyDBSService(HttpServletRequest request,
			HttpServletResponse response) {
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String pwd = request.getParameter("servicePassword");
		String capacity = request.getParameter("capacity");
		String singleFileSize = request.getParameter("singleFileSize");
		String serviceName = request.getParameter("serviceName");
		String prodId = Constants.serviceType.DBCENTER_CENTER + "";
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if (StringUtil.isBlank(pwd) && StringUtil.isBlank(capacity)
				&& StringUtil.isBlank(singleFileSize) && StringUtil.isBlank(serviceName)) {
			resultMap.put("resultCode", "10001");
			resultMap.put("resultMessage", "系统获取参数不全,请重新输入！");
			return resultMap;
		}
		
		OrderDetailRequest orderDetail = new OrderDetailRequest();
		orderDetail.setProdId(prodId);
		orderDetail.setProdByname(Constants.serviceName.DSS);
		orderDetail.setUserServIpaasPwd(pwd);
		orderDetail.setOperateType(Constants.OperateType.APPLY);
		orderDetail.setUserId(userVo.getUserId());
		orderDetail.setProdType(Constants.ProductType.IPAAS_CunChu);

		Map<String, Object> serviceMap = new HashMap<String, Object>();
		serviceMap.put("capacity", capacity);
		serviceMap.put("singleFileSize", singleFileSize);
		serviceMap.put("serviceName", serviceName);

		/** 配置中心参数 **/
		Gson prodParam = new Gson();
		orderDetail.setProdParam(prodParam.toJson(serviceMap));

		logger.info("---------调用DSS服务开通的 saveOrderDetail 方法----------");
		OrderDetailResponse orderDetailResponse = new OrderDetailResponse();
		try {
			orderDetailResponse = iOrder.saveOrderDetail(orderDetail);
			logger.info("--------- 根据orderDetailResponse结果，发送DSS服务开通的待审核提醒邮件----------");
			if (orderDetailResponse.isNeedSend() && orderDetailResponse.getEmail() != null) {
				for (EmailDetail email : orderDetailResponse.getEmail()) {
					emailSrv.sendEmail(email);
				}
			}
			resultMap.put("resultCode", orderDetailResponse.getResponseHeader().getResultCode());
			resultMap.put("data", prodId);
			resultMap.put("resultMessage", orderDetailResponse.getResponseHeader().getResultMessage());
		} catch (Exception e) {
			logger.info(e.getCause().getMessage() + e.getMessage() + "---------", e);
			resultMap.put("resultCode", "9999");
			resultMap.put("resultMessage", "系统异常，请联系管理员");
		}

		return resultMap;
	}
}

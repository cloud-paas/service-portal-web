package com.ai.paas.ipaas.idps.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.database.controller.DatabaseController;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailRequest;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailResponse;
import com.ai.paas.ipaas.user.dubbo.vo.SysParamVo;
import com.ai.paas.ipaas.user.dubbo.vo.SysParmRequest;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.StringUtil;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;

@Controller
@RequestMapping(value = "/idps")
public class IdpsController {
	@Reference
	private IOrder iOrder;
	@Reference
	private ISysParamDubbo iSysParam;
	private static final Logger logger = LogManager
			.getLogger(DatabaseController.class.getName());

	@RequestMapping(value = "/introduce")
	public String toIndex(HttpServletRequest request,
			HttpServletResponse response) {
        request.getSession().removeAttribute("list_index");
        request.getSession().setAttribute("list_index", "list_8");
		return "/idps/introduce";
	}

	/**
	 * 准备开通图片服务
	 */
	@RequestMapping(value = "/toOpenIdps")
	public String toRegisterService(ModelMap model,HttpServletRequest request,
			HttpServletResponse response) {
		SysParmRequest req=new SysParmRequest();
		req.setTypeCode(Constants.serviceName.IDPS);
		req.setParamCode("cpuNum");
		List<SysParamVo> cpuNumList=iSysParam.getSysParams(req);
		req.setParamCode("memSize");
		List<SysParamVo> memSizeList=iSysParam.getSysParams(req);
		req.setParamCode("nodeNum");
		List<SysParamVo> nodeNumList=iSysParam.getSysParams(req);
		model.addAttribute("cpuNumList", cpuNumList);
		model.addAttribute("memSizeList", memSizeList);
		model.addAttribute("nodeNumList",nodeNumList);
		
		return "/idps/openIdps";
	}

	/**
	 * 开通图片服务
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/openIdps", method = RequestMethod.POST) 
	public Map<String, Object> applyDBSService(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String cpuNum = request.getParameter("cpuNum");
		String memSize = request.getParameter("memSize");
		String nodeNum = request.getParameter("nodeNum");
		String dssServicePwd = request.getParameter("dssServicePwd");
		String dssServiceId = request.getParameter("dssServiceId");
		String serviceName = request.getParameter("serviceName");
		if (!StringUtil.isBlank(cpuNum) && !StringUtil.isBlank(memSize)
				&& !StringUtil.isBlank(nodeNum) && !StringUtil.isBlank(dssServicePwd)&& !StringUtil.isBlank(dssServiceId)
				&& !StringUtil.isBlank(serviceName)) {
			OrderDetailRequest orderDetailRequest = new OrderDetailRequest();
			orderDetailRequest.setOperateType(Constants.OperateType.APPLY);// 操作类型
			UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
			orderDetailRequest.setUserId(userVo.getUserId()); // 用户Id
			orderDetailRequest.setProdType(Constants.ProductType.IPAAS_CunChu); //PROD_IPAAS  // 产品类型
			String prodId = Constants.serviceType.IDPS_CENTER + "";
			orderDetailRequest.setProdId(prodId); // 产品id
			orderDetailRequest.setProdByname(Constants.serviceName.IDPS); // 别名
			orderDetailRequest.setUserServIpaasPwd(dssServicePwd);// 服务密码

			Map<String, Object> serviceMap = new HashMap<String, Object>();
			serviceMap.put("cpuNum", cpuNum);
			serviceMap.put("mem", memSize);
			serviceMap.put("nodeNum", nodeNum);
			serviceMap.put("dssPId", userVo.getPid());
			serviceMap.put("dssServicePwd", dssServicePwd);
			serviceMap.put("dssServiceId", dssServiceId);
			serviceMap.put("serviceName", serviceName);
			
			Gson prodParam = new Gson();
			orderDetailRequest.setProdParam(prodParam.toJson(serviceMap)); // 配置中心参数为空

			logger.info("调用saveOrderDetail----------");
			OrderDetailResponse orderDetailResponse = new OrderDetailResponse();
			try {
				orderDetailResponse = iOrder.saveOrderDetail(orderDetailRequest);
				logger.info("saveOrderDetail返回结果："	+ orderDetailResponse.getResponseHeader().getResultCode()
						+ ":"+ orderDetailResponse.getResponseHeader()
								.getResultMessage());
				resultMap.put("resultCode", orderDetailResponse.getResponseHeader().getResultCode());
				resultMap.put("data", prodId);
				resultMap.put("resultMessage", orderDetailResponse.getResponseHeader()
						.getResultMessage());
			} catch (Exception e) {
				logger.info(e.getCause().getMessage() + e.getMessage()
						+ "---------",e); 
				resultMap.put("resultCode", "9999");
				resultMap.put("resultMessage", "系统异常，请联系管理员");
			}
		}else{
			resultMap.put("resultCode", "10001");
			resultMap.put("resultMessage", "系统获取参数不全,请重新输入！");
		}
		
		return resultMap;
	}
}

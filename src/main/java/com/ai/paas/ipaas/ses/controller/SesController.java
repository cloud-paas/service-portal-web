package com.ai.paas.ipaas.ses.controller;

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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.ses.vo.SesMappingApply;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailRequest;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailResponse;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.JSonUtil;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;

@Controller
@RequestMapping(value = "/ses")
public class SesController {
	private static final Logger LOGGER = LogManager
			.getLogger(SesController.class.getName());
	
	@Reference
	private ISysParamDubbo iSysParam;

	@RequestMapping(value = "/SesApplyPage", method = { RequestMethod.GET })
	public String SesApplyPage(HttpServletRequest request,
			HttpServletResponse response) {
		return "/ses/SesApplyPage";
	}

	@RequestMapping(value = "/mapping")
	public String mapping(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		String serviceId = request.getParameter("serviceId");
		model.addAttribute("serviceId", serviceId);
		return "ses/mapping";
	}

	@ResponseBody
	@RequestMapping(value = "/saveMapping")
	public String saveMapping(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		String serviceId = request.getParameter("serviceId");
		String mapping = request.getParameter("mapping");
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId = userVo.getUserId();

		int indexName = (userId + serviceId).hashCode();
		Map properties = new HashMap();
		properties = new Gson().fromJson(mapping, properties.getClass());
		Map mappingMap = new HashMap();
		mappingMap.put("dynamic", "strict");
		mappingMap.put("properties", properties);
		Map indexmappingMap = new HashMap();
		indexmappingMap.put(indexName, mappingMap);

		SesMappingApply apply = new SesMappingApply();
		apply.setUserId(userId);
		apply.setServiceId(serviceId);
		apply.setIndexType(String.valueOf(indexName));
		apply.setIndexName(String.valueOf(indexName));
		apply.setMapping(new Gson().toJson(indexmappingMap));

		String json = new Gson().toJson(apply);
		LOGGER.debug("创建mapping json+++++++" + json, json);
		String a = "";
		try {
			a = HttpClientUtil.sendPostRequest(
					"http://10.1.228.198:10888/ipaas/ses/manage/mapping", json);

		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return a;
	}

	@RequestMapping(value = "/initapply", method = { RequestMethod.GET })
	public String initApply(HttpServletRequest request,
			HttpServletResponse response) {
		request.getSession().removeAttribute("list_index");
		request.getSession().setAttribute("list_index", "list_15");
		
		return "/ses/introduce";
	}

	@RequestMapping(value = "/sesApplyPage", method = { RequestMethod.GET })
	public String sesApplyPage(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		String sesClusterNum= SystemConfigHandler.configMap.get("SES.clusterNum.param");
		String sesReplicasNum= SystemConfigHandler.configMap.get("SES.replicasNum.param");
		String sesMemNum= SystemConfigHandler.configMap.get("SES.sesMem.param");
		String sesSharedNum= SystemConfigHandler.configMap.get("SES.shardNum.param");
		String[] clusterNumList = sesClusterNum.split(",");
		String[] shardNumList = sesSharedNum.split(",");
		String[] sesMemList = sesMemNum.split(",");
		String[] replicasNumList = sesReplicasNum.split(",");

		model.addAttribute("clusterNumList", clusterNumList);
		model.addAttribute("shardNumList", shardNumList);
		model.addAttribute("sesMemList", sesMemList);
		model.addAttribute("replicasNumList", replicasNumList);
		
		return "/ses/SesApplyPage";
	}

	@RequestMapping(value = "sesApply", method = { RequestMethod.POST }, 
			produces = "application/json;charset=utf-8")
	public @ResponseBody String sesApply(HttpServletRequest request,
			HttpServletResponse response) throws IOException,
			URISyntaxException, PaasException {

		OrderDetailRequest orderDetailRequest = new OrderDetailRequest();
		orderDetailRequest.setProdId(Constants.serviceType.SES_CENTER);
		orderDetailRequest.setProdType(Constants.ProductType.IPAAS_JiSuan); // PROD_IAAS
																			// //
																			// 1存储
																			// 2计算
																			// 3
																			// 数据库服务
		UserInfoVo userInfoVo = UserUtil.getUserSession(request.getSession());
		orderDetailRequest.setUserId(userInfoVo.getUserId());
		orderDetailRequest.setOrgCode(userInfoVo.getOrgCode());
		JSONObject prodparms = new JSONObject();
		prodparms.put("orgCode", userInfoVo.getOrgCode());
		prodparms.put("serviceName", request.getParameter("serviceName"));
		prodparms.put("clusterNum", request.getParameter("clusterNum"));
		prodparms.put("shardNum", request.getParameter("shardNum"));
		prodparms.put("sesMem", request.getParameter("sesMem"));
		prodparms.put("replicasNum", request.getParameter("replicasNum"));
		prodparms.put("serivcePwd", request.getParameter("serivcePwd"));
		orderDetailRequest.setProdByname(Constants.serviceName.SES);
		orderDetailRequest.setOperateType(Constants.OperateType.APPLY);
		orderDetailRequest.setProdParam(prodparms.toString());
		orderDetailRequest.setUserServIpaasPwd(request.getParameter("serivcePwd"));
		
		String data = JSonUtil.toJSon(orderDetailRequest);
		String portalDubboUrl= SystemConfigHandler.configMap.get("CONTROLLER.CONTROLLER.url");
		String result = HttpClientUtil.sendPostRequest(portalDubboUrl
				+ "/user/order/applyOrders", data);
		OrderDetailResponse orderDetailResponse = JSonUtil.fromJSon(result,
				OrderDetailResponse.class);
		JSONObject obj = new JSONObject();
		obj.put("code", orderDetailResponse.getResponseHeader().getResultCode());
		obj.put("message", orderDetailResponse.getResponseHeader()
				.getResultMessage());

		return obj.toString();
	}

}

package com.ai.paas.ipaas.oa;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.PageResult;
import com.ai.paas.ipaas.user.utils.gson.GsonUtil;
import com.ai.paas.ipaas.util.StringUtil;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
@RequestMapping(value = "/oa")
public class OaController {
	private static final Logger log = LogManager.getLogger(OaController.class.getName());
	
	@Reference
	private ISysParamDubbo iSysParam;

	/**
	 */
	@ResponseBody
	@RequestMapping(value = "/getOaOperators", produces = "text/html;charset=UTF-8")
	public Object getOaOperators(HttpServletRequest req,
			HttpServletResponse resp) {
		String param = req.getParameter("param");
		log.info("查询资产管理员入参======================》" + param);
		String result = null;
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("param", param); // 参数
			String portalDubboUrl= SystemConfigHandler.configMap.get("CONTROLLER.CONTROLLER.url");
			result = HttpClientUtil.sendPostRequest(portalDubboUrl + "/user/iOaApi/getOaOperators", 
					GsonUtil.toJSon(map));
			log.info("查询资产管理员出参======================》" + result);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			Map<String, String> errorMap = new HashMap<String, String>();
			errorMap.put("reslut", "1");
			errorMap.put("message", "系统异常");
			result = GsonUtil.toJSon(errorMap);
		}

		log.info(" output OaController function  getOaOperators");
		return result;
	}

	/**
	 */
	@ResponseBody
	@RequestMapping(value = "/oaAuditResultNotify", produces = "text/html;charset=UTF-8")
	public Object oaAuditResultNotify(HttpServletRequest req,
			HttpServletResponse resp) {
		log.info("===============调OA审批通知开始=============================");
		String applyNbr = req.getParameter("applyNbr");
		log.info("调OA审批通知applyNbr参数=============================" + applyNbr);
		String operType = req.getParameter("operType");
		log.info("调OA审批通知operType参数=============================" + operType);
		String variables = req.getParameter("variables");
		log.info("调OA审批通知variables参数=============================" + variables);
		Gson gson = new Gson();
		String result = null;
		if (StringUtil.isBlank(applyNbr)) {
			Map<String, String> errorMap = new HashMap<String, String>();
			errorMap.put("reslut", "1");
			errorMap.put("message", "申请单号为空");
			result = GsonUtil.toJSon(errorMap);
			return result;
		}
		if (StringUtil.isBlank(operType)) {
			Map<String, String> errorMap = new HashMap<String, String>();
			errorMap.put("reslut", "1");
			errorMap.put("message", "操作类型为空");
			result = GsonUtil.toJSon(errorMap);
			return result;
		}
		if (StringUtil.isBlank(variables)) {
			Map<String, String> errorMap = new HashMap<String, String>();
			errorMap.put("reslut", "1");
			errorMap.put("message", "变量数组为空");
			result = GsonUtil.toJSon(errorMap);
			return result;
		}

		try {
			log.info("=====参数转换前======");
			List<Map> list = gson.fromJson(variables,
					new TypeToken<List<Map>>() {
					}.getType());
			Map variablesMap = list.get(0);
			log.info("=====参数转换后======");
			// String address = "http://127.0.0.1:20881/ipaas";
			Map map = new HashMap();
			map.put("orderWoId", variablesMap.get("orderWoId"));
			map.put("orderDetailId", applyNbr);
			map.put("operType", operType);
			map.put("woDesc", operType);
			log.info("OA审批通知入参============================="
					+ GsonUtil.toJSon(map));
			String portalDubboUrl= SystemConfigHandler.configMap.get("CONTROLLER.CONTROLLER.url");
			result = HttpClientUtil.sendPostRequest(portalDubboUrl + "/user/iOaApi/oaAuditResultNotify", 
					GsonUtil.toJSon(map));
			log.info("OA审批通知出参=============================" + result);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			Map<String, String> errorMap = new HashMap<String, String>();
			errorMap.put("reslut", "1");
			errorMap.put("message", "系统异常");
			result = GsonUtil.toJSon(errorMap);
		}

		log.info(" output OaController function  getOaOperators");
		return result;
	}

	/**
	 */
	@ResponseBody
	@RequestMapping(value = "/oaAuditPremise", produces = "text/html;charset=UTF-8")
	public Object oaAuditPremise(HttpServletRequest req,
			HttpServletResponse resp) {
		log.info(" input class OaController function oaAuditPremise");
		String orderDetailId = req.getParameter("applyNbr");
		String result = null;
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("orderDetailId", orderDetailId); // 参数
			
			String portalDubboUrl= SystemConfigHandler.configMap.get("CONTROLLER.CONTROLLER.url");
			String restfulUrl = portalDubboUrl + "/user/iOaApi/oaAuditPremise";
			String restfulParam = GsonUtil.toJSon(map);
			log.info(" restful url :" + restfulUrl);
			log.info(" restful request param : " + restfulParam);
			
			result = HttpClientUtil.sendPostRequest(restfulUrl, restfulParam);
			log.info("restful response result :" + result);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			Map<String, String> errorMap = new HashMap<String, String>();
			errorMap.put("reslut", "1");
			errorMap.put("message", "系统异常");
			result = GsonUtil.toJSon(errorMap);
		}

		log.info(" output OaController function  oaAuditPremise");
		return result;
	}

	@RequestMapping(value = "/erpProjectsInit")
	public String applyAudit() {
		return "oa/erpProjectsInit";
	}

	@ResponseBody
	@RequestMapping(value = "/queryerpProjectsList")
	public Map<String, Object> queryerpProjectsList(HttpServletRequest request,
			HttpServletResponse response) {
		log.info(" input class OaController function queryerpProjectsList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String erpProjectCode = request.getParameter("erpProjectCode");
		if (erpProjectCode == null) {
			erpProjectCode = "";
		}
		String page = request.getParameter("page");
		int pageIndex = Integer.parseInt(page) - 1;
		int pageSize = Constants.PageResult.SMALL_PAGE_SIZE;
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("erpProjectCode", erpProjectCode);
			map.put("pageIndex", String.valueOf(pageIndex));
			map.put("pageSize", String.valueOf(pageSize));// 参数
			
			String portalDubboUrl= SystemConfigHandler.configMap.get("CONTROLLER.CONTROLLER.url");
			String restfulUrl = portalDubboUrl + "/user/iOaApi/getErpProjects";
			String restfulParam = GsonUtil.toJSon(map);

			log.info(" restful url :" + restfulUrl);
			log.info(" restful request param : " + restfulParam);
			String result = HttpClientUtil.sendPostRequest(restfulUrl, restfulParam);
			Gson gson = new Gson();
			PageResult<ErpProjectVo> pageResult = gson.fromJson(result,
					new TypeToken<PageResult<ErpProjectVo>>() {
					}.getType());
			log.info(" restful response .." + result);

			float pages = ((float) pageResult.getTotalCount())
					/ ((float) Constants.PageResult.SMALL_PAGE_SIZE);
			int totalPages = (int) Math.ceil(pages);
			pageResult.setCurrentPage(pageIndex + 1);
			pageResult.setTotalPages(totalPages);
			resultMap.put("resultCode", Constants.OPERATE_CODE_SUCCESS);
			resultMap.put("pageResult", pageResult);

		} catch (Exception e) {
			log.error(e.getMessage(), e);
			resultMap.put("resultCode", Constants.OPERATE_CODE_FAIL);
			resultMap.put("resultMessage", "系统异常，请联系管理员");
		}
		log.info(" output class OaController function queryerpProjectsList");
		return resultMap;
	}

}

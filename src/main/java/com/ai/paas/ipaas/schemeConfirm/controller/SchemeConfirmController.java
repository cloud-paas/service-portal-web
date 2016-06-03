package com.ai.paas.ipaas.schemeConfirm.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;

@Controller
@RequestMapping(value = "/schemeConfirm")
public class SchemeConfirmController {
	private static final Logger logger = LogManager
			.getLogger(SchemeConfirmController.class);

	String portalDubboUrl= SystemConfigHandler.configMap.get("CONTROLLER.CONTROLLER.url");
	
	/**
	 * 查询方案确认列表
	 * 
	 * @param request
	 * @param modelmap
	 * @return
	 */
	@SuppressWarnings("serial")
	@RequestMapping(value = "/schemeConfirmList")
	public String schemeConfirmList(HttpServletRequest request,
			HttpServletResponse response, Map<String, Object> map)
			throws IOException, URISyntaxException {

		int currentpage = Integer.parseInt(request.getParameter("currentpage"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));

		String operateIdStr = UserUtil.getUserSession(request.getSession())
				.getUserEmail();
		// 截取@之前的字符串
		String[] operateId = operateIdStr.split("@");
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("PageSize", pageSize);
		jsonObject.put("currentPage", currentpage);
		jsonObject.put("orderStatus", "7");
		jsonObject.put("operateId", operateId[0]);
		jsonObject.put("sortFlag", "1");

		String result = null;
		String url = "/order/queryOrdersInfo";
		logger.info("to MAIN rest:" + portalDubboUrl + url);
		try {
			result = HttpClientUtil.sendPostRequest(portalDubboUrl + url, jsonObject.toString());
			System.out.println("MAIN return :" + result);
		} catch (IOException e) {

			e.printStackTrace();
		} catch (URISyntaxException e) {

			e.printStackTrace();
		}
		int currentPage = 0;
		int totalPages = 0;
		List<Object> listinfo = new ArrayList<Object>();
		if(result!=null&&!"".equals(result)){
			JSONObject object = new JSONObject(result);
			currentPage = object.getInt("currentPage");
			totalPages = object.getInt("totalPage");
			JSONArray list = object.getJSONArray("list");
			Gson gson = new Gson();
			listinfo = gson.fromJson(list.toString(),
					new TypeToken<List<Object>>() {
					}.getType());
		}
		map.put("currentpage", currentPage);
		map.put("totalPages", totalPages);
		map.put("list", listinfo);
		return "schemeConfirm/schemeConfirm";
	}

	/**
	 * 方案确认提交
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws URISyntaxException
	 * @throws PaasException
	 */

	@RequestMapping(value = "/schemeSubmit", method = { RequestMethod.POST }, produces = "application/json;charset=utf-8")
	public @ResponseBody
	String schemeSubmit(HttpServletRequest request, HttpServletResponse response)
			throws IOException, URISyntaxException, PaasException {

		String isAgree = request.getParameter("isAgree");
		String orderDetailId = request.getParameter("orderDetailId");

		JSONObject jsondata = new JSONObject();
		jsondata.put("isAgree", isAgree);
		jsondata.put("orderDetailId", orderDetailId);

		String result = null;
		String url = "/schemeConfirm/schemeSubmit";
		logger.info("to MAIN rest:" + logger + url);
		try {
			result = HttpClientUtil.sendPostRequest(portalDubboUrl + url,
					jsondata.toString());
			logger.info("MAIN return :" + result);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}

		return result;
	}
}

package com.ai.paas.ipaas.console.des;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.console.des.vo.BindService;
import com.ai.paas.ipaas.console.des.vo.BoundResult;
import com.ai.paas.ipaas.console.des.vo.DesInfoVo;
import com.ai.paas.ipaas.console.des.vo.Tableinfo;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.HttpRequestUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.CiperUtil;
import com.ai.paas.ipaas.util.JSonUtil;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@RequestMapping(value = "/desConsole")
@Controller
public class UserDesConsoleController {
	@Reference
	private ISysParamDubbo iSysParam;
	private static final String SECURITY_KEY = "7331c9b6b1a1d521363f7bca8acb095f";// md5

	String iPaasDubboUrl = SystemConfigHandler.configMap.get("CONTROLLER.CONTROLLER.url");
	
	String authUrl = SystemConfigHandler.configMap.get("iPaas-Auth.SERVICE.IP_PORT_SERVICE");
	
	String authPwd = SystemConfigHandler.configMap.get("AUTH.AUTH_PWD.url");
	
	@RequestMapping(value = "/toDesConsole", method = { RequestMethod.GET })
	public String toManageConsole(HttpServletRequest request,
			HttpServletResponse response) {
		return "console/des/desConsole";
	}

	@RequestMapping(value = "/queryDesList", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> queryDesList(
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, URISyntaxException, PaasException {
		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageRequest<UserProdInstVo> sRequest = new SelectWithNoPageRequest<UserProdInstVo>();
		SelectWithNoPageResponse<UserProdInstVo> sResponse = new SelectWithNoPageResponse<UserProdInstVo>();

		UserProdInstVo uProdInstVo = new UserProdInstVo();
		UserInfoVo userInfoVo = UserUtil.getUserSession(request.getSession());
		uProdInstVo.setUserId(userInfoVo.getUserId());
		uProdInstVo.setUserServiceId(Constants.serviceType.DES_CENTER);
		sRequest.setSelectRequestVo(uProdInstVo);
		String desjson = JSonUtil.toJSon(sRequest);

		Map<String, String> jsonObject = new HashMap<String, String>();
		jsonObject.put("userId", userInfoVo.getUserId());
		String data = JSonUtil.toJSon(jsonObject);

		String resultBound = HttpClientUtil.sendPostRequest(iPaasDubboUrl + "/des/console/desGetBound", data);
		JSONObject bound = new JSONObject(resultBound);
		if (bound.getString("resultCode").equals(Constants.OPERATE_CODE_FAIL)) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询已绑定的DES服务失败");
			return result;
		}

		String resultDes = HttpClientUtil.sendPostRequest(iPaasDubboUrl + "/des/console/selectUserProdInsts", desjson);
		Gson gson = new Gson();
		sResponse = gson.fromJson(resultDes,
				new TypeToken<SelectWithNoPageResponse<UserProdInstVo>>() {
				}.getType());
		if (sResponse.getResponseHeader().getResultCode()
				.equals(Constants.OPERATE_CODE_FAIL)) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询开通的DES服务失败");
			return result;
		}
		
		List<UserProdInstVo> deslist = sResponse.getResultList();
		if (deslist == null || deslist.size() == 0) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "您未开通DES服务,请您开通DES服务");
			return result;
		}
		
		BoundResult boundResult = gson.fromJson(resultBound, BoundResult.class);
		List<BindService> bindServices = boundResult.getBindServices();
		List<DesInfoVo> desresultList = new ArrayList<DesInfoVo>();
		for (int i = 0; i < deslist.size(); i++) {
			DesInfoVo desInfoVo = new DesInfoVo();
			desInfoVo.setServiceId(deslist.get(i).getUserServIpaasId());
			desInfoVo.setServiceName(deslist.get(i).getServiceName());
			desresultList.add(desInfoVo);
		}
		
		if (bindServices == null || bindServices.size() == 0) {
			result.put("desList", desresultList);
		} else {
			for (int j = 0; j < desresultList.size(); j++) {
				for (int k = 0; k < bindServices.size(); k++) {
					if (desresultList.get(j).getServiceId()
							.equals(bindServices.get(k).getServiceId())) {
						DesInfoVo infoVo = new DesInfoVo();
						infoVo.setServiceId(bindServices.get(k).getServiceId());
						infoVo.setDbsServiceId(bindServices.get(k)
								.getDbsServiceId());
						infoVo.setMdsServiceId(bindServices.get(k)
								.getMdsServiceId());
						infoVo.setServiceName(desresultList.get(j)
								.getServiceName());
						infoVo.setBoundTables(bindServices.get(k)
								.getBoundTables());
						desresultList.set(j, infoVo);
					}
				}
			}

			result.put("desList", desresultList);
		}

		return result;
	}

	@RequestMapping(value = "/validateMDS", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> validateMDS(
			HttpServletRequest request, HttpServletResponse response)
			throws PaasException, IOException, URISyntaxException {
		Map<String, Object> result = new HashMap<String, Object>();
		UserInfoVo userInfoVo = UserUtil.getUserSession(request.getSession());
		String pwd = request.getParameter("password");
		String mdsId = request.getParameter("mdsService");
		String username = userInfoVo.getUserName();
		String address = authUrl + authPwd;
		String data = "";
		data = HttpRequestUtil.sendPost(address,
				"password=" + CiperUtil.encrypt(SECURITY_KEY, pwd)
						+ "&authUserName=" + username + "&serviceId=" + mdsId);
		org.apache.tapestry5.json.JSONObject json = new org.apache.tapestry5.json.JSONObject(
				data);
		String returnflag = json.getString("successed");
		if (returnflag.equalsIgnoreCase("false")) {
			String errorMessage = json.getString("authMsg");
			result.put("returnFlag", "0");
			result.put("returnMessage", "MDS服务密码错误,请重新输入！");
			return result;
		} else if (returnflag.equalsIgnoreCase("true")) {
			result.put("returnFlag", "1");
			return result;
		}

		return null;

	}

	@RequestMapping(value = "/desBind", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> desBind(
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, URISyntaxException, PaasException {
		Map<String, Object> result = new HashMap<String, Object>();
		UserInfoVo userInfoVo = UserUtil.getUserSession(request.getSession());
		Map<String, String> bindRequest = new HashMap<String, String>();
		bindRequest.put("userId", userInfoVo.getUserId());
		bindRequest.put("userName", userInfoVo.getUserName());
		bindRequest.put("serviceId", request.getParameter("desServiceId"));
		bindRequest.put("mdsServiceId", request.getParameter("mdsServiceId"));
		bindRequest.put("dbsServiceId", request.getParameter("dbsServiceId"));
		bindRequest.put("mdsServicePassword",
				request.getParameter("mdsPassword"));
		String data = JSonUtil.toJSon(bindRequest);

		String resultinfo = HttpClientUtil.sendPostRequest(iPaasDubboUrl
				+ "/des/console/desBind", data);
		JSONObject json = new JSONObject(resultinfo);
		if (json.getString("resultCode").equals(Constants.OPERATE_CODE_FAIL)) {
			result.put("resultCode", json.getString("resultCode"));
			result.put("resultMessage", json.getString("resultMessage"));
		} else {
			result.put("resultCode", json.get("resultCode"));
		}

		return result;
	}

	@RequestMapping(value = "/desUnbind", method = { RequestMethod.POST })
	public @ResponseBody Map<String, String> desUnbind(
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, URISyntaxException, PaasException {
		Map<String, String> result = new HashMap<String, String>();
		UserInfoVo userInfoVo = UserUtil.getUserSession(request.getSession());
		Map<String, String> param = new HashMap<String, String>();
		param.put("userId", userInfoVo.getUserId());
		param.put("serviceId", request.getParameter("serviceId"));
		param.put("dbsServiceId", request.getParameter("dbsServiceId"));
		param.put("mdsServiceId", request.getParameter("mdsServiceId"));
		String data = JSonUtil.toJSon(param);
		String resultinfo = "";

		resultinfo = HttpClientUtil.sendPostRequest(iPaasDubboUrl
				+ "/des/console/desUnbind", data);
		JSONObject json = new JSONObject(resultinfo);
		if (json.getString("resultCode").equals(Constants.OPERATE_CODE_FAIL)) {
			result.put("resultCode", json.getString("resultCode"));
			result.put("resultMessage", "Des解绑失败");
		} else {
			result.put("resultCode", json.getString("resultCode"));
			result.put("resultMessage", "Des解绑成功");
		}
		
		return result;
	}

	@RequestMapping(value = "/filterTable", method = { RequestMethod.POST })
	public @ResponseBody Map<String, String> filterTable(
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, URISyntaxException, PaasException {
		Map<String, String> result = new HashMap<String, String>();
		// Map<String> params=new HashMap<String, String>();
		UserInfoVo userInfoVo = UserUtil.getUserSession(request.getSession());

		String array1 = request.getParameter("jsondata");
		JSONObject object = new JSONObject(array1);
		object.put("userId", userInfoVo.getUserId());

		String resultInfo = "";
		resultInfo = HttpClientUtil.sendPostRequest(iPaasDubboUrl + "/des/console/filterTable", object.toString());
		JSONObject json = new JSONObject(resultInfo);
		if (json.getString("resultCode").equals(Constants.OPERATE_CODE_FAIL)) {
			result.put("resultCode", json.getString("resultCode"));
			result.put("resultMessage", "设置观察表失败");
		} else {
			result.put("resultCode", json.getString("resultCode"));
			result.put("resultMessage", "设置观察表成功");
		}
		
		return result;
	}

	@RequestMapping(value = "/getBindParam", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> getBindParam(
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, URISyntaxException, PaasException {
		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageRequest<UserProdInstVo> sRequest = new SelectWithNoPageRequest<UserProdInstVo>();
		SelectWithNoPageResponse<UserProdInstVo> sResponse = new SelectWithNoPageResponse<UserProdInstVo>();

		UserProdInstVo uProdInstVo = new UserProdInstVo();
		UserInfoVo userInfoVo = UserUtil.getUserSession(request.getSession());
		uProdInstVo.setUserId(userInfoVo.getUserId());
		uProdInstVo.setUserServiceId(String
				.valueOf(Constants.serviceType.DBS_CENTER));
		sRequest.setSelectRequestVo(uProdInstVo);
		String dbsjson = JSonUtil.toJSon(sRequest);

		Map<String, String> jsonObject = new HashMap<String, String>();
		jsonObject.put("userId", userInfoVo.getUserId());
		String data = JSonUtil.toJSon(jsonObject);

		String resultBound = HttpClientUtil.sendPostRequest(iPaasDubboUrl + "/des/console/desGetBound", data);
		JSONObject bound = new JSONObject(resultBound);
		if (bound.getString("resultCode").equals(Constants.OPERATE_CODE_FAIL)) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询已绑定的DES服务失败");
			return result;
		}

		String resultDbs = HttpClientUtil.sendPostRequest(iPaasDubboUrl + "/des/console/selectUserProdInsts", dbsjson);
		Gson gson = new Gson();
		sResponse = gson.fromJson(resultDbs,
				new TypeToken<SelectWithNoPageResponse<UserProdInstVo>>() {
				}.getType());
		if (sResponse.getResponseHeader().getResultCode()
				.equals(Constants.OPERATE_CODE_FAIL)) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询DBS服务失败");
			return result;
		}
		List<UserProdInstVo> dbsList = sResponse.getResultList();
		if (dbsList == null || dbsList.size() == 0) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "DBS服务资源不足，请重新开通新的DBS服务");
			return result;
		}
		uProdInstVo.setUserServiceId(String
				.valueOf(Constants.serviceType.MESSAGE_CENTER));
		sRequest.setSelectRequestVo(uProdInstVo);
		String mdsjson = JSonUtil.toJSon(sRequest);

		String resultMds = HttpClientUtil.sendPostRequest(iPaasDubboUrl
				+ "/des/console/selectUserProdInsts", mdsjson);
		sResponse = gson.fromJson(resultMds,
				new TypeToken<SelectWithNoPageResponse<UserProdInstVo>>() {
				}.getType());
		if (sResponse.getResponseHeader().getResultCode()
				.equals(Constants.OPERATE_CODE_FAIL)) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询MDS服务失败");
			return result;
		}
		
		List<UserProdInstVo> mdsList = sResponse.getResultList();
		if (mdsList == null || mdsList.size() == 0) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "MDS服务资源不足，请重新开通新的MDS服务");
			return result;
		}

		BoundResult boundResult = gson.fromJson(resultBound, BoundResult.class);
		List<BindService> bindServices = boundResult.getBindServices();

		List<String> dbsinfoList = new ArrayList<String>();
		List<String> mdsinfoList = new ArrayList<String>();

		if (bindServices.size() == 0 || bindServices == null) {
			for (int i = 0; i < dbsList.size(); i++) {
				dbsinfoList.add(dbsList.get(i).getUserServIpaasId());
			}
			for (int j = 0; j < mdsList.size(); j++) {
				mdsinfoList.add(mdsList.get(j).getUserServIpaasId());
			}
			result.put("dbsList", dbsinfoList);
			result.put("mdsList", mdsinfoList);
		} else {
			for (int i = 0; i < dbsList.size(); i++) {
				dbsinfoList.add(dbsList.get(i).getUserServIpaasId());
			}
			for (int j = 0; j < mdsList.size(); j++) {
				mdsinfoList.add(mdsList.get(j).getUserServIpaasId());
			}
			for (int x = 0; x < dbsinfoList.size(); x++) {
				for (int y = 0; y < bindServices.size(); y++) {
					if (dbsinfoList.get(x).equals(
							bindServices.get(y).getDbsServiceId())) {
						dbsinfoList.remove(bindServices.get(y)
								.getDbsServiceId());
						x = 0;
					}
				}
			}

			for (int a = 0; a < mdsinfoList.size(); a++) {
				for (int b = 0; b < bindServices.size(); b++) {
					if (mdsinfoList.get(a).equals(
							bindServices.get(b).getMdsServiceId())) {
						mdsinfoList.remove(bindServices.get(b)
								.getMdsServiceId());
						a = 0;
					}
				}
			}
			if (dbsinfoList == null || dbsinfoList.size() == 0) {
				result.put("resultCode", Constants.OPERATE_CODE_FAIL);
				result.put("resultMessage", "DBS服务资源不足，请重新开通新的DBS服务");
				return result;
			}

			if (mdsinfoList == null || mdsinfoList.size() == 0) {
				result.put("resultCode", Constants.OPERATE_CODE_FAIL);
				result.put("resultMessage", "MDS服务资源不足，请重新开通新的MDS服务");
				return result;
			}
			result.put("dbsList", dbsinfoList);
			result.put("mdsList", mdsinfoList);
		}

		return result;
	}

	@RequestMapping(value = "/getTableInfo", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> getTableInfo(
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, URISyntaxException, PaasException {
		Map<String, Object> result = new HashMap<String, Object>();
		UserInfoVo userInfoVo = UserUtil.getUserSession(request.getSession());
		Map<String, String> param = new HashMap<String, String>();
		param.put("userId", userInfoVo.getUserId());
		param.put("serviceId", request.getParameter("serviceId"));
		String data = JSonUtil.toJSon(param);

		String table = HttpClientUtil.sendPostRequest(iPaasDubboUrl
				+ "/des/console/desgetBoundTableInfo", data);
		JSONObject object = new JSONObject(table);
		if (object.getString("resultCode").equals(Constants.OPERATE_CODE_FAIL)) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "系统错误，请稍后重试！");
		} else {
			Gson gson = new Gson();
			Tableinfo tableinfo = gson.fromJson(table, Tableinfo.class);

			if (tableinfo.getBoundTables().length == 0
					&& tableinfo.getUnboundTables().length == 0) {
				result.put("resultCode", Constants.OPERATE_CODE_FAIL);
				result.put("resultMessage", "未建立观察表,请去DBS控制台建立观察表");
				return result;
			}
			result.put("boundTable", tableinfo.getBoundTables());
			result.put("unboundTable", tableinfo.getUnboundTables());
		}

		return result;

	}

}

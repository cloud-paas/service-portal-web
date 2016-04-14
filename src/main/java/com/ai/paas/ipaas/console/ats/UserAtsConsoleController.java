package com.ai.paas.ipaas.console.ats;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.cache.CacheUtils;
import com.ai.paas.ipaas.console.ats.vo.SearchOneResponse;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IAtsConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.IDssConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.IProdProductDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.ProdProductVo;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.JSonUtil;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

/**
 * Ats用户控制台* 
 * @author mapl
 * 
 */

@RequestMapping(value = "/atsConsole")
@Controller
public class UserAtsConsoleController {
	@Reference
	private ISysParamDubbo iSysParam;
	private static final Logger logger = LogManager
			.getLogger(UserAtsConsoleController.class.getName());

	@Reference
	private IDssConsoleDubboSv dssConsoleDubboSv;
	
	@Reference
	private IAtsConsoleDubboSv atsConsoleDubboSv;
	
	@Reference
	private IProdProductDubboSv prodProductDubboSv;

	@RequestMapping(value = "/toAtsConsole")
	public String toManageConsole(HttpServletRequest req,
			HttpServletResponse resp) {
		SelectWithNoPageResponse<ProdProductVo> prodProductVoresponse = null;
		SelectWithNoPageRequest<ProdProductVo> prodProductVoRequest = new SelectWithNoPageRequest<ProdProductVo>();
		ProdProductVo  prodProductVo = new ProdProductVo();
		short prodId = Constants.serviceType.TRANSACTION_CENTER;
		prodProductVo.setProdId(prodId);
		prodProductVoRequest.setSelectRequestVo(prodProductVo);
		try {
			prodProductVoresponse = prodProductDubboSv.selectProduct(prodProductVoRequest);
		} catch (PaasException e) {
			e.printStackTrace();
		}
		prodProductVo = prodProductVoresponse.getResultList().get(0);
		req.setAttribute("prodName", prodProductVo.getProdName());
		return "console/ats/atsConsole";
	}

	/**
	 * Ats列表查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryAtsList")
	@ResponseBody
	public Map<String, Object> queryAtsList(HttpServletRequest req,
			HttpServletResponse resp) {

		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			String prodId = String.valueOf(Constants.serviceType.TRANSACTION_CENTER);
			vo.setUserServiceId(prodId);
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = atsConsoleDubboSv.selectUserProdInsts(selectWithNoPageRequest);
			result.put("resultCode", Constants.OPERATE_CODE_SUCCESS);
			result.put("resultList", new ArrayList<UserProdInstVo>());
			
			result.put("resultCode", response.getResponseHeader().getResultCode());
			result.put("resultMessage", response.getResponseHeader().getResultMessage());
			result.put("resultList", response.getResultList());			
			
			
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常！");
			logger.error(e);

		}

		return result;
	}	
	
	
	@RequestMapping(value = "/toModifyAtsServPwd")
	public String toModifyAtsServPwd(HttpServletRequest req,HttpServletResponse resp) {
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		String userServId = req.getParameter("userServId"); 
		String parentUrl = req.getParameter("parentUrl"); 
		req.setAttribute("parentUrl",parentUrl);
		String productType = req.getParameter("productType"); 
		req.setAttribute("productType",productType);
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			vo.setUserServId(Long.parseLong(userServId));
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = atsConsoleDubboSv.selectUserProdInstById(selectWithNoPageRequest);		
			if(Constants.OPERATE_CODE_SUCCESS.equals(response.getResponseHeader().getResultCode())){
				req.setAttribute("userProdInstVo",response.getResultList().get(0));	
				HttpSession session = req.getSession();
				long timeStamp = System.currentTimeMillis();
				session.setAttribute(String.valueOf(timeStamp), response.getResultList().get(0));
				req.setAttribute("timeStamp", String.valueOf(timeStamp));
			}	
			
		} catch (Exception e) {
			logger.error(e.getMessage(),e);

		}
		return "console/ats/atsModifyServPwd";
	}
	
	@RequestMapping(value="/searchUsages")
	public String searchUsages(HttpServletRequest request,HttpServletResponse response) throws PaasException, IOException, URISyntaxException
	{
		 
		UserProdInstVo userProdInstVo=new UserProdInstVo();
		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
		userProdInstVo.setUserId(userInfoVo.getUserId());
		String userServId=request.getParameter("userServId");
		
		userProdInstVo.setUserServId(Long.parseLong(userServId));
		userProdInstVo.setUserServiceId(String.valueOf(Constants.serviceType.TRANSACTION_CENTER));
		String  error="";
		error=request.getParameter("errorinfo");
		if(error!=""&&error!=null){
			userProdInstVo.setUserServParam("error");
			request.setAttribute("flag", "1");
		}else{
			request.setAttribute("flag", "0");
		}
		String params=JSonUtil.toJSon(userProdInstVo);		
		String address = CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");
		String result=HttpClientUtil.sendPostRequest(address+"/ats/console/searchUsages", params);
		//String result=HttpClientUtil.sendPostRequest("http://127.0.0.1:20881/ipaas/ats/console/searchUsages", params);
		Gson gson=new Gson();
		SelectWithNoPageResponse <UserProdInstVo> resultresponse=gson.fromJson(result, new TypeToken<SelectWithNoPageResponse<UserProdInstVo>>(){}.getType());
		if(resultresponse.getResponseHeader().getResultCode().equals(Constants.OPERATE_CODE_FAIL))
		{
			request.setAttribute("resultCode", resultresponse.getResponseHeader().getResultCode());
			request.setAttribute("resultMessage", resultresponse.getResponseHeader().getResultMessage());
			request.setAttribute("userServId", Long.parseLong(userServId));
			return "console/ats/atsDetail";
		}
		request.setAttribute("userServId", resultresponse.getResultList().get(0).getUserServId());
		request.setAttribute("resultCode", resultresponse.getResponseHeader().getResultCode());
		request.setAttribute("usageVo", resultresponse.getResultList().get(0));
		
		UserProdInstVo prodInstVo=resultresponse.getResultList().get(0);
		request.setAttribute("signatureId", prodInstVo.getAtsUserPageVo().getTopicUsage().get(0).getTopicEnName());
		request.setAttribute("partitions", prodInstVo.getAtsUserPageVo().getTopicUsage().size());
 
		return "console/ats/atsDetail";
		
	}

	
	
	@RequestMapping(value="/searchOneMessage",method={RequestMethod.POST})
	public @ResponseBody Map<String,Object> searchOneMessage(HttpServletRequest request,HttpServletResponse response) throws PaasException, IOException, URISyntaxException
	{
		Map<String, Object>resultinfo=new HashMap<String, Object>();
		JSONObject params=new JSONObject();
		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
		int offset=Integer.parseInt(request.getParameter("offset"))-1;
		params.put("userId", userInfoVo.getUserId());
		params.put("offset", offset);
		params.put("partition", request.getParameter("partitionId"));
		params.put("topicEnName", request.getParameter("topicEnName"));
		params.put("userServId", request.getParameter("userServId"));
		params.put("serviceId", String.valueOf(Constants.serviceType.TRANSACTION_CENTER));
		String errorinfo="";
		errorinfo=request.getParameter("errorinfo");
		if(errorinfo!=null&&errorinfo!=""){
			params.put("messageType", "1");
		}else{
			params.put("messageType", "0");
		}
		String data=params.toString();
		String address = CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");
		String result=HttpClientUtil.sendPostRequest(address+"/ats/console/searchOneMessage", data);
		//String result=HttpClientUtil.sendPostRequest("http://127.0.0.1:20881/ipaas/ats/console/searchOneMessage", data);
		JSONObject jsonObject=new JSONObject(result);
		if(jsonObject.getString("resultCode").equals(Constants.OPERATE_CODE_FAIL))
		{
			resultinfo.put("resultCode", Constants.OPERATE_CODE_FAIL);
			
			resultinfo.put("resultMessage", jsonObject.getString("resultMsg"));
		
			return resultinfo;
		}
		SearchOneResponse searchOneResponse=new Gson().fromJson(result, SearchOneResponse.class);
		resultinfo.put("resultCode", Constants.OPERATE_CODE_SUCCESS);
		resultinfo.put("searchMessage", searchOneResponse.getTopicMessage());
		
		return resultinfo;
		
	}
	
	
	/**
	 * @param request
	 * @param response
	 * @return
	 * @throws PaasException 
	 * @throws URISyntaxException 
	 * @throws IOException 
	 */
	@RequestMapping(value="/skipMessage",method={RequestMethod.POST})
	public @ResponseBody Map<String, String> skipMessage(HttpServletRequest request,HttpServletResponse response) throws PaasException, IOException, URISyntaxException{
		Map<String, String> resultinfo=new HashMap<String, String>();
		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
		Map<String, String> params=new HashMap<String, String>();
		params.put("userId", userInfoVo.getUserId());
		params.put("message", request.getParameter("message"));
		params.put("serviceId", request.getParameter("userServIpassId"));
		params.put("topicEnName",request.getParameter("topicEnName"));
		params.put("offset", "1");
		params.put("partition", request.getParameter("partitionId"));
		String errorinfo="";
		errorinfo=request.getParameter("errorinfo");
		if(errorinfo!=null&&errorinfo!=""){
			params.put("messageType", "1");
		}else{
			params.put("messageType", "0");
		}
		String data=JSonUtil.toJSon(params);
		String address = CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");
		String result=HttpClientUtil.sendPostRequest(address+"/ats/console/skipMessage", data);
		//String result=HttpClientUtil.sendPostRequest("http://127.0.0.1:20881/ipaas/ats/console/skipMessage", data);
		JSONObject object=new JSONObject(result);
		if(result==""&&result==null){
			resultinfo.put("resultCode", Constants.OPERATE_CODE_FAIL);
			resultinfo.put("resultMsg", "请求失败！");
			return resultinfo;
		}
		resultinfo.put("resultCode", object.getString("resultCode"));
		resultinfo.put("resultMsg", object.getString("resultMsg"));
		return resultinfo;
		
	}
	
	@RequestMapping(value="/resendMessage",method={RequestMethod.POST})
	public @ResponseBody Map<String, String> resendMessage(HttpServletRequest request,HttpServletResponse response) throws PaasException, IOException, URISyntaxException{
		Map<String, String>resultinfo =new HashMap<String, String>();
		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
		Map<String, String> params=new HashMap<String, String>();
		params.put("userId", userInfoVo.getUserId());
		params.put("message",request.getParameter("message"));
		params.put("serviceId", request.getParameter("userServIpassId"));
		params.put("topicEnName",request.getParameter("topicEnName"));
		params.put("partition", request.getParameter("partitionId"));
		String errorinfo="";
		errorinfo=request.getParameter("errorinfo");
		if(errorinfo!=null&&errorinfo!=""){
			params.put("messageType", "1");
		}else{
			params.put("messageType", "0");
		}
		String data=JSonUtil.toJSon(params);
		String address = CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");
		String result=HttpClientUtil.sendPostRequest(address+"/ats/console/resendMessage", data);
		//String result=HttpClientUtil.sendPostRequest("http://127.0.0.1:20881/ipaas/ats/console/resendMessage", data);
		JSONObject object=new JSONObject(result);
		if(result==""&&result==null){
			resultinfo.put("resultCode", Constants.OPERATE_CODE_FAIL);
			resultinfo.put("resultMsg", "请求失败！");
			return  resultinfo ;
		}
		
		resultinfo.put("resultCode", object.getString("resultCode"));
		resultinfo.put("resultMsg", object.getString("resultMsg"));
		return resultinfo;
	}
	
	
	
	
	
	
}

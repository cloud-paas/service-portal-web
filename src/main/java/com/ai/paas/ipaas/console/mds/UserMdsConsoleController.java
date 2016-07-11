package com.ai.paas.ipaas.console.mds;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.List;
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
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IDssConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.IMdsConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.interfaces.IaasConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.vo.MdsSearchMessageVo;
import com.ai.paas.ipaas.user.dubbo.vo.MdsUserSubscribeVo;
import com.ai.paas.ipaas.user.dubbo.vo.ResponseHeader;
import com.ai.paas.ipaas.user.dubbo.vo.ResponseSubPathList;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.JSonUtil;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;

/**
 * MDS用户控制台
 * @author mapl
 */
@RequestMapping(value = "/mdsConsole")
@Controller
public class UserMdsConsoleController {
	private static final Logger logger = LogManager.getLogger(UserMdsConsoleController.class.getName());
	
	@Reference
	private ISysParamDubbo iSysParam;

	@Reference
	private IaasConsoleDubboSv iaasConsoleDubboSv;
	
	@Reference
	private IMdsConsoleDubboSv mdsConsoleDubboSv;

	@Reference
	private IDssConsoleDubboSv dssConsoleDubboSv;
	
	@RequestMapping(value = "/toMdsConsole")
	public String toMdsConsole(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		SelectWithNoPageRequest<UserProdInstVo> req = new SelectWithNoPageRequest<UserProdInstVo>();
		UserProdInstVo selectRequestVo = new UserProdInstVo();
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId=userVo.getUserId();
		selectRequestVo.setUserId(userId);
		selectRequestVo.setUserServiceId(Constants.serviceType.MESSAGE_CENTER+"");
		req.setSelectRequestVo(selectRequestVo);
		SelectWithNoPageResponse<UserProdInstVo> res = iaasConsoleDubboSv.selectUserProdInsts(req);
		List<UserProdInstVo> list = res.getResultList();
		
		model.addAttribute("prodList", list);
		
		return "console/mds/mdsConsole";
	}

	@RequestMapping(value = "/queryMdsInstById")	
	public String queryMdsInstById(HttpServletRequest req,
			HttpServletResponse resp) {

		SelectWithNoPageResponse<UserProdInstVo> response = null;
		String userServId = req.getParameter("userServId"); 
		String subscribeName = req.getParameter("subscribeName");
		String currentConsumer = req.getParameter("currentConsumer");
		List<String> listSupPath =null;
		ResponseSubPathList listSupPathResponse = null;
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			vo.setUserServId(Long.parseLong(userServId));
			Map<String , String> subscribeNameMap = new HashMap<String,String>();
			subscribeNameMap.put("subscribeName", subscribeName);
			vo.setUserServParamMap(subscribeNameMap);
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = mdsConsoleDubboSv.selectMdsById(selectWithNoPageRequest);		
			listSupPathResponse = mdsConsoleDubboSv.getListSubPath(selectWithNoPageRequest);	
			if(Constants.OPERATE_CODE_SUCCESS.equals(response.getResponseHeader().getResultCode())){
				UserProdInstVo prodVo = response.getResultList().get(0);
				String str = prodVo.getUserServParam();
				Map<String , String > map = new HashMap<String,String>();
				map = new Gson().fromJson(str, map.getClass());
				prodVo.setUserServParamMap(map);
				prodVo.getMdsUserPageVo().getTopicUsage();
				req.setAttribute("userProdInstVo",prodVo);	
			}	
			if(Constants.OPERATE_CODE_SUCCESS.equals(listSupPathResponse.getResultCode())){
				listSupPath =listSupPathResponse.getListSubPath();
				req.setAttribute("listSupPath",listSupPath);	
			}	
			
		} catch (Exception e) {
			logger.error(e.getMessage(),e);

		}
		req.setAttribute("currentConsumer", currentConsumer);
		return "console/mds/mdsDetail";
	}
	
	@RequestMapping(value = "/cancleMds",produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public Map<String, Object> cancleDss(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String userServId=req.getParameter("userServId");
		UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
		ResponseHeader responseHeader = new ResponseHeader();
		UserProdInstVo vo = new UserProdInstVo();
		vo.setUserId(userVo.getUserId());
		vo.setUserServId(Long.parseLong(userServId));
		
		try {
			// 注销
			responseHeader = dssConsoleDubboSv.cancleUserProdInst(vo);
			result.put("resultCode", responseHeader.getResultCode());
			result.put("resultMessage", responseHeader.getResultCode());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "注销异常！");
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}
	
	@RequestMapping(value = "/searchMessage",produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public Map<String, Object> searchMessage(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String userServId=req.getParameter("userServId");
		String partitionId = req.getParameter("partitionId");
		int offsettemp= Integer.parseInt(req.getParameter("offset"))-1;
		String offset =String.valueOf(offsettemp);
		String topicEnName = req.getParameter("topicEnName");
		UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
		ResponseHeader responseHeader = new ResponseHeader();
		MdsSearchMessageVo vo = new MdsSearchMessageVo();
		vo.setUserId(userVo.getUserId());
		vo.setUserServId(Long.parseLong(userServId));
		vo.setPartition(partitionId);
		vo.setOffset(offset);
		vo.setTopicEnName(topicEnName);
		try {
			// 注销
			responseHeader = mdsConsoleDubboSv.searchMessage(vo);
			result.put("resultCode", responseHeader.getResultCode());
			result.put("resultMessage", responseHeader.getResultMessage());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "注销异常！");
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}
	
	@RequestMapping(value = "/createSubscribe",produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public Map<String, Object> createSubscribe(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String userServIpaasId=req.getParameter("userServIpaasId");		//订阅服务的服务paasid
		String userId = req.getParameter("userId");			
		String subscribeName = req.getParameter("subscribeName"); //输入的订阅者
		String topicEnName = req.getParameter("topicEnName");	//订阅服务的队列名称
		ResponseHeader responseHeader = new ResponseHeader();
		MdsUserSubscribeVo vo = new MdsUserSubscribeVo();
		vo.setUserId(userId);
		vo.setSubscribeName(subscribeName);
		vo.setUserServIpaasId(userServIpaasId);
		vo.setTopicEnName(topicEnName);
		try {
			// 注销
			responseHeader = mdsConsoleDubboSv.createSubscribe(vo);
			result.put("resultCode", responseHeader.getResultCode());
			result.put("resultMessage", responseHeader.getResultMessage());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "注销异常！");
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}
	
	@RequestMapping(value = "/getSubscribe",produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public Map<String, Object> getSubscribe(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String subscribeName = req.getParameter("subscribeName"); //输入的订阅者
		String topicEnName = req.getParameter("topicEnName");	//订阅服务的队列名称
		ResponseHeader responseHeader = new ResponseHeader();
		MdsUserSubscribeVo vo = new MdsUserSubscribeVo();
		vo.setSubscribeName(subscribeName);
		vo.setTopicEnName(topicEnName);
		try {
			// 验证是否存在
			responseHeader = mdsConsoleDubboSv.getSubscribe(vo);
			result.put("resultCode", responseHeader.getResultCode());
			result.put("resultMessage", responseHeader.getResultMessage());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "注销异常！");
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}
	
	
	@RequestMapping(value="/resendMessage",method={RequestMethod.POST})
	public @ResponseBody Map<String, String> resendMessage(HttpServletRequest request,HttpServletResponse response) throws PaasException, IOException, URISyntaxException{
		Map<String, String> resultMap=new HashMap<String, String>();
		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
		Map<String, String> params=new HashMap<String, String>();
		params.put("userId", userInfoVo.getUserId());
		params.put("message", request.getParameter("message"));
		params.put("serviceId", request.getParameter("userServIpassId"));
		params.put("topicEnName", request.getParameter("topicEnName"));
		params.put("partition", request.getParameter("partition"));
		String data=JSonUtil.toJSon(params);
		
		String portalDubboUrl = SystemConfigHandler.configMap.get("CONTROLLER.CONTROLLER.url");
		String result = HttpClientUtil.sendPostRequest(portalDubboUrl+"/mds/console/resendMessage", data);
		
		JSONObject object=new JSONObject(result);
		resultMap.put("resultCode", object.getString("resultCode"));
		resultMap.put("resultMsg", object.getString("resultMsg"));
		
		return resultMap;
	}
	
	@RequestMapping(value="/skipMessage",method={RequestMethod.POST})
	public @ResponseBody Map<String,String> skipMessage(HttpServletRequest request,HttpServletResponse response) throws PaasException, IOException, URISyntaxException{
		Map<String, String> resultMap=new HashMap<String, String>();
		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
		Map<String, String> params=new HashMap<String, String>();
		params.put("userId", userInfoVo.getUserId());
		params.put("message",request.getParameter("message"));
		params.put("serviceId", request.getParameter("userServIpassId"));
		params.put("topicEnName", request.getParameter("topicEnName"));
		params.put("partition", request.getParameter("partition"));
		params.put("offset", request.getParameter("offset"));
		String data=JSonUtil.toJSon(params);
		
		String portalDubboUrl = SystemConfigHandler.configMap.get("CONTROLLER.CONTROLLER.url");
		String result = HttpClientUtil.sendPostRequest(portalDubboUrl + "/mds/console/skipMessage", data);
		
		JSONObject object=new JSONObject(result);
		resultMap.put("resultCode", object.getString("resultCode"));
		resultMap.put("resultMsg", object.getString("resultMsg"));
		
		return resultMap;
	}
}
